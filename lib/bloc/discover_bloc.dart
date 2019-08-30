import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DiscoverBloc {
  final repository = Repository();
  final discoverMoviesFetcher = PublishSubject<DiscoverModel>();

  Observable<DiscoverModel> get allDiscoverMovies =>
      discoverMoviesFetcher.stream;

  fetchAllDiscoverMovies(String genreId, bool isPopular) async {
    DiscoverModel discoverModel = isPopular ? await repository.fetchAllDiscoverPopularMovies(genreId) : await repository.fetchAllDiscoverLatestMovies(genreId);
    discoverMoviesFetcher.sink.add(discoverModel);
  }

  void dispose() {
    discoverMoviesFetcher.close();
  }
}

final blocDiscover = DiscoverBloc();
