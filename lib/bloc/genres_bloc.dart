import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresBloc {
  final repository = Repository();
  final genresFetcher = PublishSubject<GenreModel>();

  Stream<GenreModel> get allGenres => genresFetcher.stream;

  fetchAllGenres() async {
    GenreModel genreModel = await repository.fetchAllGenres();
    genresFetcher.sink.add(genreModel);
  }

  void dispose() {
    genresFetcher.close();
  }
}

final blocGenres = GenresBloc();
