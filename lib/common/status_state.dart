enum StatusState { initial, loading, loaded, error }

extension StatusStateExtension on StatusState {
  bool isInitial() => this == StatusState.initial;
  bool isLoading() => this == StatusState.loading;
  bool isLoaded() => this == StatusState.loaded;
  bool isError() => this == StatusState.error;
}
