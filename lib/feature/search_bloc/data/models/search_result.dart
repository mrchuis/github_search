import 'package:flutter/foundation.dart' show immutable;
import 'package:github_search/feature/search_bloc/data/models/search_model.dart';

@immutable
abstract class SearchResult {
  const SearchResult();
}

@immutable
class SearchResultLoading implements SearchResult {
  const SearchResultLoading();
}

@immutable
class SearchResultNoResult implements SearchResult {
  const SearchResultNoResult();
}

@immutable
class SearchResultWithError implements SearchResult {
  final Object? error;

  const SearchResultWithError(this.error);
}

@immutable
class SearchResultWithResult implements SearchResult {
  final List<Item> result;
  const SearchResultWithResult(this.result);
}
