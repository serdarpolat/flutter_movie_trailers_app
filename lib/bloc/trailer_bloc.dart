import 'package:movie_traliers/model/trailer_model.dart';
import 'package:movie_traliers/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TrailerBloc {
  final repository = Repository();
  final trailerFetcher = PublishSubject<TrailerModel>();

  Observable<TrailerModel> get allTrailersOfMovie =>
      trailerFetcher.stream;

  fetchAllTrailers(int movieId) async {
    TrailerModel trailerModel = await repository.fetchtrailers(movieId);
    trailerFetcher.sink.add(trailerModel);
  }

  void dispose() {
    trailerFetcher.close();
  }
}

final blocTrailer = TrailerBloc();
