import 'package:get_it/get_it.dart';
import 'package:github_search/feature/search_bloc/data/datasources/search_datasource.dart';
import 'package:github_search/feature/search_bloc/data/repositories/search_repository_impl.dart';
import 'package:github_search/feature/search_bloc/domain/repositories/search_repository.dart';
import 'package:github_search/feature/search_bloc/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => SearchBloc(sl()));

  ///Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(sl()),
  );

  ///DataSource
  sl.registerLazySingleton<SearchDataSource>(
    () => SearchDataSourceImpl(),
  );
}
