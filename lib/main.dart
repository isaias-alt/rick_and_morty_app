import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/config/injection/injection_container.dart';
import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';
import 'config/injection/injection_container.dart' as injection;
import 'package:rick_and_morty_app/config/themes/app_theme.dart';
import 'package:rick_and_morty_app/config/routes/app_routes.dart';
import 'package:rick_and_morty_app/presentation/providers/providers.dart';

void main() async {
  await injection.setUp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CharacterProvider>(
          create: (_) => CharacterProvider(
            characterRepository: getit<CharacterRepository>(),
          ),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        )
      ],
      child: const _BuildMaterialApp(),
    );
  }
}

class _BuildMaterialApp extends StatelessWidget {
  const _BuildMaterialApp();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp.router(
      title: 'Rick and Morty App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(
        themeProvider: themeProvider,
      ),
    );
  }
}
