import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

void setLogFunction(String message) {
  if (kDebugMode) {
    log(message);
  }
}

String formatUzPhone(String input) {
  final digits = input.replaceAll(RegExp(r'\D'), '');

  if (digits.length != 9) {
    throw FormatException(
      'Invalid phone number length. Expected 9 digits, got ${digits.length}',
    );
  }

  final operator = digits.substring(0, 2); // 90
  final part1 = digits.substring(2, 5); // 800
  final part2 = digits.substring(5, 7); // 70
  final part3 = digits.substring(7, 9); // 60

  return '+998 $operator $part1-$part2-$part3';
}

String generateUuidV4() {
  final uuid = const Uuid();
  return uuid.v4();
}

Future<String> getDeviceUserAgent() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return "Mozilla/5.0 (Linux; Android ${androidInfo.version.release}; ${androidInfo.model}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Mobile Safari/537.36";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      final systemVersion = iosInfo.systemVersion.replaceAll('.', '_');
      return "Mozilla/5.0 (${iosInfo.utsname.machine}; CPU iPhone OS $systemVersion like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1";
    }
  } catch (e) {
    return "Mozilla/5.0 (Mobile; rv:100.0) Gecko/100.0 Firefox/100.0";
  }

  return "Mozilla/5.0";
}
