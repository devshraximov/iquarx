import 'package:dio/dio.dart';
import 'package:iquarix/iquarx_app.dart';

class PhoneAuthRepositoryImpl implements PhoneAuthRepository {
  PhoneAuthRepositoryImpl(this._dio, this._deviceService, this._errorMapper);

  final Dio _dio;
  final DeviceInfoService _deviceService;
  final ErrorMapper _errorMapper;

  @override
  ResultFuture<DataMap> submitPhone({required String phone}) async {
    final deviceId = await _deviceService.getDeviceId();
    final deviceName = await _deviceService.getDeviceName();

    final request = PhoneAuthRequestModel(
      phone: phone,
      deviceId: deviceId,
      deviceName: deviceName,
    );

    try {
      // final response = await _dio.post(
      //   ApiConstants.submitPhone,
      //   data: request.toJson(),
      // );
      // return Right(response.data);
      await Future.delayed(const Duration(milliseconds: 1100));
      if (phone == '+998908007060') {
        return Right({'success': true, 'message': 'Success'});
      } else {
        throw Exception('test error');
      }
    } catch (error) {
      return Left(_errorMapper.map(error));
    }
  }
}
