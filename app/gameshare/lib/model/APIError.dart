class APIError {
  final String _errorMsg;
  final int _statusCode;

  APIError (this._errorMsg, this._statusCode,);

  String get errorMsg => _errorMsg;
  int get statusCode => _statusCode;
}