import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/infrastructure/datasources/character_datasource_impl.dart';
import 'package:rick_and_morty_app/infrastructure/repositories/character_repository_impl.dart';

class CharacterProvider with ChangeNotifier {
  final characters = [];
  final characterDatasource = CharacterDataSourceImpl();

  Future<void> getCharacters(int page) async {
    final characterRepositoryImpl =
        CharacterRepositoryImpl(characterDatasource);
    characters.add(characterRepositoryImpl.getCharacters(page: page));
    notifyListeners();
  }

  Future<List<Character>> getCharacter(String name) async {
    final characterRepositoryImpl =
        CharacterRepositoryImpl(characterDatasource);
    final character = characterRepositoryImpl.getCharacter(name);
    return character;
  }
}
