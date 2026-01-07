import 'package:iquarix/iquarx_app.dart';

abstract class OtpRepository {
  ResultFuture<DataMap> submitOtp({required String otp});
}
