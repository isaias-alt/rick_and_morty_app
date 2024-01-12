import 'dart:convert';

import 'package:rick_and_morty_app/domain/datasources/character_datasource.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/infrastructure/mappers/character_mapper.dart';
import 'package:rick_and_morty_app/infrastructure/models/character_model.dart';

class CharacterDataSourceImpl extends CharacterDatasource {
  final url = 'rickandmortyapi.com';

  @override
  Future<List<Character>> getCharacters({int page = 1}) async {
    final result = await http
        .get(Uri.https(url, '/api/character', {'page': page.toString()}));
    final characterResponse = CharacterModel.fromJson(json.decode(result.body));
    final List<Character> characters = characterResponse.results!
        .map(
            (character) => CharacterMapper.characterResponseToEntity(character))
        .toList();

    return characters;
  }

  @override
  Future<List<Character>> getCharacter({required String name}) async {
    final result =
        await http.get(Uri.https(url, '/api/character/', {'name': name}));
    final characterSearchResponse =
        CharacterModel.fromJson(json.decode(result.body));
    final List<Character> characters = characterSearchResponse.results!
        .map((search) => CharacterMapper.characterResponseToEntity(search))
        .toList();
    return characters;
  }
}
