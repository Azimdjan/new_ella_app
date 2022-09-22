import 'package:ella/core/inputs/name_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('name input test', () {
    test('empty name field', () {
      final name = NameInput.pure();
      expect(name.error, NameInputError.empty);
    });

    test('short name', () {
      final name = NameInput.dirty('Li    ');
      expect(name.error, NameInputError.short);
    });

    test('long name', () {
      final name = NameInput.dirty('Lifdjsfnakdnfjksdanfkjafjkdnsfafdsf');
      expect(name.error, NameInputError.long);
    });

    test('correct name', () {
      final name = NameInput.dirty('Lee');
      expect(name.error, null);
    });
  });
}
