part of 'bloc.dart';


class SearchState extends Equatable {
  /// Статус состояния
  final StatusState? statusState;
  // Список результатов поиска
  final List<String>? searchList;

  const SearchState({
    this.statusState = StatusState.initial,
    this.searchList,
  });

  factory SearchState.initial() => const SearchState(
    statusState: StatusState.initial,
  );

  SearchState copyWith({
    StatusState? statusState,
    List<String>? searchList,
  }) => SearchState(
    statusState: statusState ?? this.statusState,
    searchList: searchList ?? this.searchList,
  );

  @override
  List<Object?> get props => [
    statusState,
    searchList,
  ];
}
