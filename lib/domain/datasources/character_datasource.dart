import 'package:rick_and_morty_app/domain/entities/character.dart';

abstract class CharacterDatasource {
  Future<List<Character>> getCharacters({int page = 1});
  Future<List<Character>> getCharacter({required String name});
}
