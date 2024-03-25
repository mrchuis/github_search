part of 'bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  static final _textSearchController = TextEditingController();
  static final _textSearchRxController = TextEditingController();

  late Stream<SearchResult?> _results;

  final _searchTerms = BehaviorSubject<String>();

  SearchBloc(this.searchRepository) : super(SearchState.initial()) {
    _textSearchController.addListener(_textControllerListener);

    on<_InitSearchEvent>(_initSearchEventHandler);
    on<_UpdateSearchEvent>(_updateSearchEventHandler);
    on<_GetItemsSearchEvent>(_getItemsSearchEventHandler);
    on<_ClearSearchEvent>(_clearSearchEventHandler);

    add(SearchEvent.init());
  }

  TextEditingController get controller => _textSearchController;
  TextEditingController get controllerRx => _textSearchRxController;
  Stream<SearchResult?> get results => _results;

  @override
  Future<void> close() {
    _searchTerms.close();
    controller.dispose();
    controllerRx.dispose();

    return super.close();
  }

  void searchText(String query) {
    _searchTerms.add(query);
  }

  void _initSearchEventHandler(
    _InitSearchEvent event, Emitter<SearchState> emit,
  ) {
    _results = _searchTerms
      .distinct()
      .debounceTime(const Duration(milliseconds: 500))
      .switchMap<SearchResult?>((String query) {
        if (query.isEmpty) {
          return Stream<SearchResult?>.value(null);
        } else {
          return Rx.fromCallable(() => searchRepository.getSearchRx(text: query))
            .map(
              (results) => results.isEmpty
                ? const SearchResultNoResult()
                : SearchResultWithResult(results),
              )
              .startWith(const SearchResultLoading())
              .onErrorReturnWith((error, _) => SearchResultWithError(error));
        }
    });
  }

  void _clearSearchEventHandler(
    _ClearSearchEvent event, Emitter<SearchState> emit,
  ) => add(SearchEvent.update(searchList: []));

  Future<void> _getItemsSearchEventHandler(
    _GetItemsSearchEvent event, Emitter<SearchState> emit,
  ) async {
    add(SearchEvent.update(statusState: StatusState.loading));
    final getSearchItemsOrFailure = await searchRepository.getSearchBloc(text: event.text);

    getSearchItemsOrFailure.fold(
      (error) {
        add(SearchEvent.update(statusState: StatusState.error, searchList: []));
      },
      (searchModel) {
        add(SearchEvent.update(statusState: StatusState.loaded, searchList: searchModel!.items!.map((e) => e.htmlUrl ?? "").toList()));
      },
    );
  }

  void _updateSearchEventHandler(
    _UpdateSearchEvent event, Emitter<SearchState> emit,
  ) => emit(
    state.copyWith(
      statusState: event.statusState,
      searchList: event.searchList,
    ),
  );

  void _textControllerListener() {
    Debouncer.run(
      () {
        if (_textSearchController.text.isNotEmpty) {
          add(SearchEvent.getItems(text: _textSearchController.text));
        }
      }
    );
    add(SearchEvent.clearSearch());
  }
}
