import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

abstract class DeviceInfoService {
  Future<String> getDeviceId();

  Future<String> getDeviceName();
}

class DeviceInfoServiceImpl implements DeviceInfoService {
  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  @override
  Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      final info = await _plugin.androidInfo;
      return info.id;
    }
    if (Platform.isIOS) {
      final info = await _plugin.iosInfo;
      return info.identifierForVendor ?? '';
    }
    return 'unknown';
  }

  @override
  Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      final info = await _plugin.androidInfo;
      return info.model;
    }
    if (Platform.isIOS) {
      final info = await _plugin.iosInfo;
      return info.name;
    }
    return 'unknown';
  }
}
