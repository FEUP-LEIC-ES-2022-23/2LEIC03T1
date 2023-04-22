class Review {
  final String _reviewText;
  final int _rating;
  final int _gameId;
  final String _userEmail;

  Review(
    this._reviewText,
    this._rating,
    this._gameId,
    this._userEmail,
  );

  int get gameId => _gameId;

  String get reviewText => _reviewText;

  int get rating => _rating;

  String get userEmail => _userEmail;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      json['text'],
      json['rating'],
      json['gameId'],
      json['userEmail'],
    );
  }
}
