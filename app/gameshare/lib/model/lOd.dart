class LoD { //Likes or Dislikes
  final String _userEmail;
  int _likeOrDislike; // 1 is like, 2 is dislike

  LoD(
      this._userEmail,
      this._likeOrDislike,
      );

  int get likeOrDislike => _likeOrDislike;
  String get userEmail => _userEmail;
  set likeOrDislike(int likeOrDislike) => _likeOrDislike = likeOrDislike;

  factory LoD.fromJson(Map<String, dynamic> json) {
    return LoD(
      json['userEmail'],
      json['likeOrDislike'],
    );
  }
}