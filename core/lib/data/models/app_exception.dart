abstract class ApplicationException implements Exception {}

class GenericApplicationException extends ApplicationException {
  GenericApplicationException({required this.message});

  final String? message;
}