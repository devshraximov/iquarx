import 'package:iquarix/iquarx_app.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> sendLocation(double lat, double lng);
}
