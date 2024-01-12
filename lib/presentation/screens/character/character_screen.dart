import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;
  const CharacterScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name!.toUpperCase()),
      ),
      body: _CharacterInfoView(character: character),
    );
  }
}

class _CharacterInfoView extends StatelessWidget {
  const _CharacterInfoView({
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: Hero(
                  tag: character.id!,
                  child: Image.network(
                    character.image!,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Status: ${character.status!}'.toUpperCase(),
            style: textStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Specie: ${character.species!}'.toUpperCase(), style: textStyle),
          const SizedBox(
            height: 20,
          ),
          Text('Gender: ${character.gender!}'.toUpperCase(), style: textStyle),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
