import 'package:iquarix/core/helper/typedefs.dart';

abstract class PhoneAuthRepository {
  ResultFuture<DataMap> submitPhone({required String phone});
}
