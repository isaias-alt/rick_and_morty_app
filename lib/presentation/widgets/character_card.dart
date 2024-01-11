import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/presentation/providers/api_provider.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.scrollController,
    required this.isLoading,
    required this.apiProvider,
  });

  final ScrollController scrollController;
  final bool isLoading;
  final ApiProvider apiProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: isLoading
          ? apiProvider.characters.length + 1
          : apiProvider.characters.length,
      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length) {
          final character = apiProvider.characters[index];
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
                  child: CircularProgressIndicator(color: Color(0xFF22D8F0))));
        }
      },
    );
  }
}
