class Genre {
  final String _name;
  final String _slug;

  Genre(
    this._name,
    this._slug,
  );

  String get name => _name;

  String get slug => _slug;

  factory Genre.fromJson(List<dynamic> json, int idx) {
    Map<String, dynamic> result = json[idx];

    return Genre(
      result['name'],
      result['slug'],
    );
  }
}
