import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DiscoverBloc {
  final repository = Repository();
  final discoverMoviesFetcher = PublishSubject<DiscoverModel>();

  Observable<DiscoverModel> get allDiscoverMovies =>
      discoverMoviesFetcher.stream;

  fetchAllDiscoverMoviesMovies(String genreId) async {
    DiscoverModel discoverModel = await repository.fetchAllDiscoverMovies(genreId);
    discoverMoviesFetcher.sink.add(discoverModel);
  }

  void dispose() {
    discoverMoviesFetcher.close();
  }
}

final blocDiscover = DiscoverBloc();
