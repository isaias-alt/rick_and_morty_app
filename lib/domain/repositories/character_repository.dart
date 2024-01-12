import 'package:rick_and_morty_app/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({int page = 1});
  Future<List<Character>> getCharacter(String name);
}
