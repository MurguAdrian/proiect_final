import 'package:proiect_final/src/actions/get_movies.dart';
import 'package:proiect_final/src/models/app_state.dart';
import 'package:redux/redux.dart';

// state + action => state
Reducer<AppState> reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, GetMovies>(_getMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
]);

AppState _getMovies(AppState state, GetMovies action) {
  return state.copyWith(isLoading: true);
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  final List<String> titles = <String>[];
  titles.addAll(state.titles);
  titles.addAll(action.titles);

  return state.copyWith(
    titles: titles,
    page: state.page + 1,
    isLoading: false,
  );
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.copyWith(isLoading: false);
}
