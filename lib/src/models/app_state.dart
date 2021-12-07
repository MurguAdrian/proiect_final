class AppState {
  AppState({
    this.titles = const <String>[],
    this.isLoading = false,
    this.page = 1,
  });

  final List<String> titles;
  final bool isLoading;
  final int page;

  AppState copyWith({
    final List<String>? titles,
    final bool? isLoading,
    final int? page,
  }) {
    return AppState(
      titles: titles ?? this.titles,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'AppState{titles: $titles, isLoading: $isLoading, page: $page}';
  }
}
