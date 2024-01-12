import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/infrastructure/datasources/character_datasource_impl.dart';
import 'package:rick_and_morty_app/infrastructure/repositories/character_repository_impl.dart';

class CharacterProvider with ChangeNotifier {
  final List<Character> characters = [];
  final CharacterDataSourceImpl characterDatasource = CharacterDataSourceImpl();

  Future<void> getCharacters(int page) async {
    final characterRepository = CharacterRepositoryImpl(characterDatasource);
    final characterList = await characterRepository.getCharacters(page: page);
    characters.addAll(characterList);
    notifyListeners();
  }

  Future<List<Character>> getCharacter(String name) async {
    final characterRepository = CharacterRepositoryImpl(characterDatasource);
    final characterList = await characterRepository.getCharacter(name);
    characters.clear();
    characters.addAll(characterList);
    return characters;
  }
}
