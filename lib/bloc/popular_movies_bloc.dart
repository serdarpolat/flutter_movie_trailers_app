import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final repository = Repository();
  final moviePopularFetcher = PublishSubject<ItemModel>();
  
  Observable<ItemModel> get allPopularMovies => moviePopularFetcher.stream;

  fetchAllPopularMovies() async {
    ItemModel itemModel = await repository.fetchPopularMovies();
    moviePopularFetcher.sink.add(itemModel);
  }

  void dispose() {
    moviePopularFetcher.close();
  }
}

final blocPopular = MoviesBloc();
