import 'package:movie_traliers/resources/movie_api_provider.dart';

class ItemModel {
  int page;
  int totalPages;
  int totalResults;
  List<Result> results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson, bool isPopular) {
    if (parsedJson['results'] != null) {
      page = parsedJson['page'];
      totalPages = parsedJson['total_pages'];
      totalResults = parsedJson['total_results'];
      List<Result> temp = [];

      for (var i = 0; i < parsedJson['results'].length; i++) {
        Result result = Result(parsedJson['results'][i]);
        temp.add(result);
      }

      if (isPopular) {
        temp.sort((a, b) {
          return b.voteAverage.compareTo(a.voteAverage);
        });
      } else {
        temp.sort((a, b) {
          return DateTime.parse(b.releaseDate).compareTo(DateTime.parse(a.releaseDate));
        });
      }

      results = temp;
    }
  }
}

class Result {
  int voteCount;
  int id;
  bool video;
  String voteAverage;
  String title;
  String popularity;
  String posterPath;
  List<int> genreIds = [];
  String overview;
  String releaseDate;
  String backdropPath;
  bool adult;

  Result(results) {
    voteCount = results['vote_count'];
    id = results['id'];
    video = results['video'];
    voteAverage = results['vote_average'].toString();
    title = results['title'];
    popularity = results['popularity'].toString();
    posterPath =baseImageUrl+''+results['poster_path'];
    overview = results['overview'];
    releaseDate = results['release_date'];
    backdropPath = results['backdrop_path'];

    for (var i = 0; i < results['genre_ids'].length; i++) {
      genreIds.add(results['genre_ids'][i]);
    }

    adult = results['adult'];
  }

  int get getVoteCount => voteCount;
  int get getId => id;
  bool get getVideo => video;
  String get getVoteAverage => voteAverage;
  String get getTitle => title;
  String get getPopularity => popularity;
  String get getPosterPath => posterPath;
  List<int> get getGenreIds => genreIds;
  String get getOverview => overview;
  String get getReleaseDate => releaseDate;
  String get getBackdropPath => backdropPath;
  bool get getAdult => adult;
}
