import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';

class CharacterProvider with ChangeNotifier {
  final List<Character> characters = [];
  final CharacterRepository characterRepository;

  CharacterProvider({required this.characterRepository});

  Future<void> getCharacters(int page) async {
    final characterList = await characterRepository.getCharacters(page: page);
    characters.addAll(characterList);
    notifyListeners();
  }

  Future<List<Character>> getCharacter(String name) async {
    final characterList = await characterRepository.getCharacter(name);
    characters.clear();
    characters.addAll(characterList);
    return characters;
  }
}
