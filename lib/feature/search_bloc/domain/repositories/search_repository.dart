import 'package:dartz/dartz.dart';
import 'package:github_search/core/error/failure.dart';
import 'package:github_search/feature/search_bloc/data/models/search_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchModel?>> getSearchBloc({required String text});

  Future<List<Item>> getSearchRx({required String text});
}
