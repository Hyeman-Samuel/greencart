import 'package:greencart_app/src/core/core.dart';

final class ClientException extends AppException {
  final String message;

  const ClientException({required this.message});

  @override
  String toString() => message;
}
