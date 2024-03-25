part of 'bloc.dart';

abstract class SearchEvent {
  /// Инициализация блока
  static _InitSearchEvent init() => _InitSearchEvent();
  /// Обновление состояния
  static _UpdateSearchEvent update({
    StatusState? statusState,
    List<String>? searchList,
  }) => _UpdateSearchEvent(
    statusState,
    searchList,
  );
  /// Запрос на получение списка
  static _GetItemsSearchEvent getItems({required String text}) =>
    _GetItemsSearchEvent(text);
  /// Очистить поиск
  static _ClearSearchEvent clearSearch() => _ClearSearchEvent();
}

class _InitSearchEvent extends SearchEvent {}

class _ClearSearchEvent extends SearchEvent {}

class _GetItemsSearchEvent extends SearchEvent {
  final String text;

  _GetItemsSearchEvent(this.text);
}

class _UpdateSearchEvent extends SearchEvent {
  final StatusState? statusState;
  final List<String>? searchList;

  _UpdateSearchEvent(
    this.statusState,
    this.searchList,
  );
}
