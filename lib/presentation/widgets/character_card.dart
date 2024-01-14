import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/presentation/providers/providers.dart';

class CharacterCard extends StatelessWidget {
  final ScrollController scrollController;
  final bool isLoading;

  const CharacterCard({
    super.key,
    required this.scrollController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final characterProvider = context.watch<CharacterProvider>();

    return ListView.builder(
      controller: scrollController,
      itemCount: isLoading
          ? characterProvider.characters.length + 1
          : characterProvider.characters.length,
      itemBuilder: (context, index) {
        if (index < characterProvider.characters.length) {
          final character = characterProvider.characters[index];
          return InkWell(
            onTap: () => context.go('/character', extra: character),
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Hero(
                      tag: character.id!,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(character.image!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.name!.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          character.species!,
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          character.status!,
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF22D8F0),
              ),
            ),
          );
        }
      },
    );
  }
}
