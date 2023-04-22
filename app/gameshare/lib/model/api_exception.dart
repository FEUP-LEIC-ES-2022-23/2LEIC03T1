class ApiException implements Exception {
  final String _errorMsg;
  final int _statusCode;

  ApiException(
    this._errorMsg,
    this._statusCode,
  );

  String get errorMsg => _errorMsg;

  int get statusCode => _statusCode;

  @override
  String toString() {
    return '$errorMsg (Error $statusCode)';
  }
}
