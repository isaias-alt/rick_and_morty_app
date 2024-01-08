import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/core/models/character_model.dart';

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];

  Future<void> getCharacters(int page) async {
    final result = await http
        .get(Uri.https(url, '/api/character', {'page': page.toString()}));
    final response = CharacterModel.fromJson(json.decode(result.body));
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, '/api/character/', {'name': name}));
    final response = CharacterModel.fromJson(json.decode(result.body));
    return response.results!;
  }
}
