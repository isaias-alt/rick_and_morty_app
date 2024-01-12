import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/presentation/providers/character/character_provider.dart';
import 'package:rick_and_morty_app/presentation/providers/theme/theme_provider.dart';
import 'package:rick_and_morty_app/presentation/widgets/character_card.dart';
import 'package:rick_and_morty_app/presentation/widgets/search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;
  @override
  void initState() {
    super.initState();
    final characterProvider = context.read<CharacterProvider>();
    characterProvider.getCharacters(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading = true;
        setState(() {});
        page++;
        await characterProvider.getCharacters(page);
        setState(() {});
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final characterProvider = context.watch<CharacterProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final appBarTextStyle = Theme.of(context).appBarTheme.titleTextStyle;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty App', style: appBarTextStyle),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IconButton(
                onPressed: () {
                  themeProvider.isDarkMode = !themeProvider.isDarkMode;
                },
                icon: Icon(
                  themeProvider.isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
              ))
        ],
      ),
      body: SizedBox(
          child: characterProvider.characters.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF22D8F0),
                  ),
                )
              : _CharacterView(
                  characterProvider: characterProvider,
                  scrollController: scrollController,
                  isLoading: isLoading,
                )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSearch(context: context, delegate: SearchCharacter());
          },
          child: const Icon(Icons.search_outlined)),
    );
  }
}

class _CharacterView extends StatelessWidget {
  final CharacterProvider characterProvider;
  final ScrollController scrollController;
  final bool isLoading;
  const _CharacterView({
    required this.characterProvider,
    required this.scrollController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return CharacterCard(
      scrollController: scrollController,
      isLoading: isLoading,
      characterProvider: characterProvider,
    );
  }
}
