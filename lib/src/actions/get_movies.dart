class GetMovies {
  const GetMovies(this.result);

  final void Function(dynamic action) result;
}

class GetMoviesSuccessful {
  const GetMoviesSuccessful(this.titles);

  final List<String> titles;
}

class GetMoviesError {
  const GetMoviesError(this.error);

  final Object error;
}
