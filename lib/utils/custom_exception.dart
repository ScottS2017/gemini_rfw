/// A class that allows for customized Exceptions
class CustomException implements Exception {

  /// Creates an instance of [CustomException].
  CustomException(this.message);

  /// The message to be displayed when there is an exception.
  final String message;

  /// Returns a string that includes the message.
  @override
  String toString() => 'CustomJsonException: $message';
}
