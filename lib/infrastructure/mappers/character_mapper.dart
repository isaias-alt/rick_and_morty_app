import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/infrastructure/models/character_response_model.dart';

class CharacterMapper {
  static Character characterResponseToEntity(
          CharacterResponseModel characterResponseModel) =>
      Character(
        id: characterResponseModel.id,
        name: characterResponseModel.name,
        status: characterResponseModel.status,
        species: characterResponseModel.species,
        type: characterResponseModel.type,
        gender: characterResponseModel.gender,
        image: characterResponseModel.image,
        episode: characterResponseModel.episode,
        url: characterResponseModel.url,
        created: characterResponseModel.created,
      );
}
