import 'package:movie_traliers/model/credits_model.dart';
import 'package:movie_traliers/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CreditsBloc {
  final repository = Repository();
  final creditFetcher = PublishSubject<CreditsModel>();

  Observable<CreditsModel> get allCreditsOfMovie =>
      creditFetcher.stream;

  fetchAllCredits(int movieId) async {
    CreditsModel creditModel = await repository.fetchcredits(movieId);
    creditFetcher.sink.add(creditModel);
  }

  void dispose() {
    creditFetcher.close();
  }
}

final blocCredit = CreditsBloc();
