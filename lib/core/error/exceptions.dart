import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  final String label;

  const ServerException({
    required this.message,
    required this.statusCode,
    required this.label,
  });

  @override
  List<Object?> get props => [message, statusCode, label];
}

class CacheException extends Equatable implements Exception {
  final String message;
  final String label;
  final int statusCode;

  const CacheException({
    required this.message,
    required this.label,
    this.statusCode = 500,
  });

  @override
  List<Object?> get props => [message, statusCode, label];
}
