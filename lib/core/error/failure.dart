import 'package:equatable/equatable.dart';
import 'package:iquarix/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
    required this.label,
  });

  final String message;
  final String label;
  final int statusCode;

  String get errorMessage => '$statusCode Error [$label]: \n$message';

  @override
  List<Object?> get props => [message, statusCode, label];
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.statusCode,
    required super.label,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
    required super.label,
  });

  factory ServerFailure.fromException(ServerException exception) {
    return ServerFailure(
      message: exception.message,
      statusCode: exception.statusCode,
      label: exception.label,
    );
  }
}
