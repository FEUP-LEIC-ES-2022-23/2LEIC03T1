import 'package:gameshare/model/genre.dart';
import 'package:test/test.dart';

void main() {
  test('Crating a genre instance', () {
    const List<dynamic> data = [
      {'name': 'Action', 'slug': 'action'},
      {'name': 'Puzzle', 'slug': 'puzzle'}
    ];

    Genre genreAction = Genre.fromJson(data, 0);
    Genre genrePuzzle = Genre.fromJson(data, 1);

    expect(genreAction.name == 'Action', true);
    expect(genreAction.slug == 'action', true);
    expect(genrePuzzle.name == 'Puzzle', true);
    expect(genrePuzzle.slug == 'puzzle', true);
  });
}
