import 'package:rick_and_morty_app/infrastructure/models/character_response_model.dart';

class CharacterModel {
  Info? info;
  List<CharacterResponseModel>? results;

  CharacterModel({
    this.info,
    this.results,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<CharacterResponseModel>.from(json["results"]!
                .map((x) => CharacterResponseModel.fromJson(x))),
      );
}

class Info {
  int? count;
  int? pages;
  String? next;
  dynamic prev;

  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );
}
