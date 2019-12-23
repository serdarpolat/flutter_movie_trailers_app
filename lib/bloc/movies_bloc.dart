import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final repository = Repository();
  final movieNowPlayingFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get allNowPlayingMovies =>
      movieNowPlayingFetcher.stream;

  fetchAllNowPlayingMovies() async {
    ItemModel itemModel = await repository.fetchNowPlayingMovies();
    movieNowPlayingFetcher.sink.add(itemModel);
  }

  void dispose() {
    movieNowPlayingFetcher.close();
  }
}

final bloc = MoviesBloc();
