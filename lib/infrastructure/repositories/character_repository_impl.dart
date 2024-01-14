import 'package:rick_and_morty_app/domain/datasources/character_datasource.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl extends CharacterRepository {
  final CharacterDatasource characterdatasource;

  CharacterRepositoryImpl({required this.characterdatasource});
  @override
  Future<List<Character>> getCharacters({int page = 1}) {
    return characterdatasource.getCharacters(page: page);
  }

  @override
  Future<List<Character>> getCharacter(String name) {
    return characterdatasource.getCharacter(name: name);
  }
}
