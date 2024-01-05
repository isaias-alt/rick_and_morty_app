import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/core/models/character_model.dart';
import 'package:rick_and_morty_app/presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen(), routes: [
    GoRoute(
      path: 'character',
      builder: (context, state) {
        final character = state.extra as Character;
        return CharacterScreen(character: character);
      },
    ),
  ])
]);
