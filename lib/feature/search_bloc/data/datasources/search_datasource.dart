import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:github_search/common/utils/dio_manager.dart';
import 'package:github_search/core/error/exeption.dart';
import 'package:github_search/feature/api.dart';
import 'package:github_search/feature/search_bloc/data/models/search_model.dart';

abstract class SearchDataSource {
  Future<SearchModel?> getSearchItems({required String text});
}

class SearchDataSourceImpl implements SearchDataSource {
  @override
  Future<SearchModel?> getSearchItems({required String text}) async {
    final response = await DioManager.dio.get(Api.searchRepGET(text: text));

    if (response.statusCode == 200) {
      return compute(_decodeAndParseJson, response.data);
    } else {
      throw ServerException();
    }
  }

  SearchModel _decodeAndParseJson(dynamic data) {
    return SearchModel.fromJson(data);
  }
}
