import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

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
