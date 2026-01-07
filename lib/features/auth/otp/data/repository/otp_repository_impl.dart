import 'package:dio/dio.dart';

import 'package:iquarix/iquarx_app.dart';

class OtpRepositoryImpl implements OtpRepository {
  OtpRepositoryImpl(this._dio, this._errorMapper);

  final Dio _dio;
  final ErrorMapper _errorMapper;

  @override
  ResultFuture<DataMap> submitOtp({required String otp}) async {
    try {
      // final response = await _dio.post(ApiConstants.submitOtp, data: otp);
      if (otp == '123456') {
        return Right({'success': true, 'message': 'Success'});
      } else {
        throw DioException(
          error: Response(statusCode: 401, requestOptions: RequestOptions()),
          requestOptions: RequestOptions(),
        );
      }
    } catch (error) {
      return Left(_errorMapper.map(error));
    }
  }
}
