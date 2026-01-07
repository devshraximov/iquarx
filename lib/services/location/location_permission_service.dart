import 'package:geolocator/geolocator.dart';
import 'package:iquarix/core/helper/enums.dart';

class LocationPermissionService {
  Future<LocationAccessStatus> ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return LocationAccessStatus.serviceDisabled;

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return LocationAccessStatus.denied;
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationAccessStatus.deniedForever;
    }

    // whileInUse yoki always
    return LocationAccessStatus.granted;
  }

  Future<void> openLocationSettings() => Geolocator.openLocationSettings();
  Future<void> openAppSettings() => Geolocator.openAppSettings();
}
