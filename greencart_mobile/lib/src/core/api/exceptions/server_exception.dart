import 'package:greencart_app/src/core/core.dart';

final class ServerException extends AppException {
  final String message;
  final List<dynamic> errors;

  const ServerException({required this.message, required this.errors});

  factory ServerException.fromJson(Map<String, dynamic> json) =>
      ServerException(
        message: json['message'] as String,
        errors: json['errors'] as List<dynamic>,
      );

  @override
  String toString() => message;
}
