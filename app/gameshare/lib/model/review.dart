class Review {
  final String _reviewText;
  final int _rating;
  final int _gameId;
  final String _userEmail;
  final String? _gameName;

  Review(
    this._reviewText,
    this._rating,
    this._gameId,
    this._userEmail,
      this._gameName,
  );

  int get gameId => _gameId;

  String get reviewText => _reviewText;

  int get rating => _rating;

  String get userEmail => _userEmail;
  String get gameName => _gameName??"";

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      json['text'],
      json['rating'],
      json['gameId'],
      json['userEmail'],
      json['gameName'],
    );
  }
}
