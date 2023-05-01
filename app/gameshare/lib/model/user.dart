class Users {
  final String _about;
  final String _email;
  final String _name;
  final String _img;

  Users(
      this._name,
      this._img,
      this._email,
      this._about,
      );

  String get name => _name;
  String get about => _about;
  String get email => _email;
  String get img => _img;

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      json['name'],
      json['image'],
      json['email'],
      json['about'],
    );
  }
}
