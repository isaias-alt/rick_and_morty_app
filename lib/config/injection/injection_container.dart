import 'package:http/http.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/domain/datasources/character_datasource.dart';
import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_app/infrastructure/datasources/character_datasource_impl.dart';
import 'package:rick_and_morty_app/infrastructure/repositories/character_repository_impl.dart';

final GetIt getit = GetIt.instance;

Future<void> setUp() async {
  getit.registerLazySingleton<Client>(
    () => Client(),
  );

  getit.registerLazySingleton<CharacterDatasource>(
    () => CharacterDatasourceImpl(client: getit()),
  );

  getit.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(characterdatasource: getit()),
  );
}
