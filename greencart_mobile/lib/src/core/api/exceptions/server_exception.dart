import 'package:greencart_app/src/core/core.dart';

final class ServerException extends AppException {
  final String name;
  final String message;

  const ServerException({required this.message, required this.name});

  factory ServerException.fromJson(Map<String, dynamic> json) =>
      ServerException(
        name: json['name'] as String,
        message: json['message'] as String,
      );

  @override
  String toString() => message;
}
