import 'package:geolocator/geolocator.dart';

class LocationService {
  Stream<Position> getPositionStream() async* {
    while (true) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      yield position;
      await Future.delayed(const Duration(seconds: 15));
    }
  }
}
