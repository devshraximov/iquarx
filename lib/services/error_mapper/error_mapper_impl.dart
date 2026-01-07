import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iquarix/core/constants/locale_keys.dart';

import 'package:iquarix/iquarx_app.dart';

class ErrorMapperImpl implements ErrorMapper {
  @override
  Failure map(Object error) {
    if (error is DioException) {
      return _mapDioError(error);
    }

    if (error is SocketException) {
      return const ServerFailure(
        message: 'internet_is_unavailable',
        statusCode: 0,
        label: 'network_error',
      );
    }

    if (error is TimeoutException) {
      return const ServerFailure(
        message: "could_not_connect_to_server",
        statusCode: 0,
        label: 'time_out_error',
      );
    }

    if (error is Failure) {
      return error;
    }

    return ServerFailure(
      message: LocaleKeys.errorUnknownError.tr(),
      statusCode: -1,
      label: 'unknown_error',
    );
  }

  Failure _mapDioError(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;

    switch (statusCode) {
      case 400:
        return ServerFailure(
          label: 'bad_request',
          statusCode: statusCode,
          message: _extractMessage(error),
        );
      case 401:
        return ServerFailure(
          label: 'unauthorized',
          statusCode: statusCode,
          message: _extractMessage(error),
        );
      case 403:
        return ServerFailure(
          label: 'access_denied',
          statusCode: statusCode,
          message: _extractMessage(error),
        );
      case 404:
        return ServerFailure(
          label: 'not_found',
          statusCode: statusCode,
          message: _extractMessage(error),
        );
      case 500:
      case 502:
      case 503:
        return ServerFailure(
          label: 'server_error',
          statusCode: statusCode,
          message: _extractMessage(error),
        );
      default:
        return ServerFailure(
          label: 'unknown_failure',
          statusCode: statusCode,
          message: _extractMessage(error),
        );
    }
  }

  String _extractMessage(DioException error) {
    final data = error.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return LocaleKeys.authErrorRequestNotProcessed.tr();
  }
}
