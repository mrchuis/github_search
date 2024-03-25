import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/common/status_state.dart';
import 'package:github_search/common/utils/debouncer.dart';
import 'package:github_search/feature/search_bloc/data/models/search_result.dart';
import 'package:github_search/feature/search_bloc/domain/repositories/search_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'event.dart';
part 'state.dart';
part 'search_bloc.dart';
