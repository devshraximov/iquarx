import 'package:dio/dio.dart';
import 'package:iquarix/features/home/data/model/geo_update_log_model.dart';
import 'package:iquarix/features/home/data/repository/home_repository.dart';
import 'package:iquarix/iquarx_app.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._dio, this._handleError);

  final Dio _dio;
  final ErrorMapper _handleError;

  @override
  Future<Either<Failure, void>> sendLocation(double lat, double lng) async {
    final request = GeoUpdateLogModel(
      companyId: 'company-123',
      entityId: 'vehicle-123',
      type: 'GEOUPDATE',
      source: 'mobile',
      payload: PayloadModel(
        geo: GeoModel(lat: lat, lng: lng, accuracy: 10),
      ),
      occurredAt: DateTime.now().toIso8601String(),
      eventId: generateUuidV4(),
    );

    try {
      await _dio.post(ApiConstants.events, data: request.toJson());
      return Right(null);
    } catch (error) {
      return Left(_handleError.map(error));
    }
  }
}
