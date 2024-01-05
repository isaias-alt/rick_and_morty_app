import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/presentation/providers/api_provider.dart';
import 'package:rick_and_morty_app/presentation/providers/theme_provider.dart';
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
    final apiProvider = context.read<ApiProvider>();
    apiProvider.getCharacters(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading = true;
        setState(() {});
        page++;
        await apiProvider.getCharacters(page);
        setState(() {});
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = context.watch<ApiProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    const TextStyle appBarTextStyle = TextStyle(
        fontFamily: 'Schwifty',
        fontWeight: FontWeight.w800,
        color: Color(0xFF22D8F0),
        shadows: [
          Shadow(color: Color(0xFF8EFF4D), offset: Offset(0, 0), blurRadius: 5)
        ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty App', style: appBarTextStyle),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    themeProvider.isDarkMode = !themeProvider.isDarkMode;
                  });
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
          child: apiProvider.characters.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF22D8F0),
                  ),
                )
              : _CharacterView(
                  apiProvider: apiProvider,
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
  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;
  const _CharacterView(
      {required this.apiProvider,
      required this.scrollController,
      required this.isLoading});

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
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF22D8F0))));
        }
      },
    );
  }
}
