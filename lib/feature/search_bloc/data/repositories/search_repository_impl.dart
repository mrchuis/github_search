import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/exeption.dart';
import 'package:github_search/core/error/failure.dart';
import 'package:github_search/feature/search_bloc/data/datasources/search_datasource.dart';
import 'package:github_search/feature/search_bloc/data/models/search_model.dart';
import 'package:github_search/feature/search_bloc/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource searchDataSource;

  SearchRepositoryImpl(this.searchDataSource);

  @override
  Future<Either<Failure, SearchModel?>> getSearchBloc({required String text}) async {
    try {
      final searchItems = await searchDataSource.getSearchItems(text: text);

      return Right(searchItems);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<List<Item>> getSearchRx({required String text}) async {
    try {
      final searchItems = await searchDataSource.getSearchItems(text: text);

      return searchItems?.items ?? <Item>[];
    } on ServerException {
      throw ServerException();
    }
  }
}
