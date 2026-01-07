import 'dart:convert';

import 'package:iquarix/iquarx_app.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final LocalSource localSource;

  final Dio dio;

  int retryCount = 0;
  final int maxRetry = 2;

  TokenInterceptor({required this.dio, required this.localSource});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      String accessToken = localSource.getAccessToken();
      if (accessToken.isNotEmpty) {
        options.headers['authorization'] = accessToken;
      }
      handler.next(options);
    } catch (e) {
      handler.reject(DioException(requestOptions: options));
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && retryCount < maxRetry) {
      retryCount++;
      try {
        var dio = Dio();
        dio.interceptors.add(
          LogInterceptor(
            request: true,
            requestBody: true,
            requestHeader: true,
            responseBody: true,
            responseHeader: true,
          ),
        );

        final refreshToken = localSource.getRefreshToken();

        if (refreshToken.isEmpty) {
          return;
        }

        final response = await dio.request(
          '${ApiConstants.baseUrl}/auth/get-access-token',
          options: Options(method: 'POST'),
          data: {'refreshToken': refreshToken},
        );

        if ((response.statusCode ?? 0) >= 200 &&
            (response.statusCode ?? 0) < 300) {
          debugPrint(json.encode(response.data));
        }
        String accessToken = response.data['accessToken'] ?? '';
        debugPrint(accessToken);
        if (accessToken.isNotEmpty) {
          localSource.setAccessToken(accessToken: accessToken);

          var headers = {'authorization': accessToken};

          final response = await dio.request(
            '${ApiConstants.baseUrl}${err.requestOptions.path}',
            options: Options(
              method: err.requestOptions.method,
              headers: headers,
            ),
            queryParameters: err.requestOptions.queryParameters,
            data: err.requestOptions.data,
          );

          retryCount = 0;
          return handler.resolve(response);
        }
      } catch (e) {
        debugPrint("REFRESH_TOKEN_ERROR ->$e");
        retryCount = 0;
        // LocalSource.getInstance().logOut();
        // Get.offAllNamed(RoutesApp.welcomePage);
      }
    }

    handler.next(err);
  }
}
