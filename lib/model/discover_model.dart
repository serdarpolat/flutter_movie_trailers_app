import 'package:movie_traliers/resources/movie_api_provider.dart';

class DiscoverModel {
  int page;
  int totalPages;
  int totalResults;
  List<ResultDiscover> results = [];

  DiscoverModel.fromJson(Map<String, dynamic> parsedJson, bool isPopular) {
    if (parsedJson['results'] != null) {
      page = parsedJson['page'];
      totalPages = parsedJson['total_pages'];
      totalResults = parsedJson['total_results'];
      List<ResultDiscover> temp = [];

      for (var i = 0; i < parsedJson['results'].length; i++) {
        ResultDiscover result = ResultDiscover(parsedJson['results'][i]);
        temp.add(result);
      }

      if(isPopular) {
        temp.sort((a,b) => b.voteAverage.compareTo(a.voteAverage));
      } else {
        temp.sort((a,b) => b.releaseDate.compareTo(a.releaseDate));
      }

      results = temp;
    }
  }
}

class ResultDiscover {
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

  String fakeImgPath = 'https://raw.githubusercontent.com/serdarpolat/flutter_movie_trailers_app/master/assets/images/no_image.jpg';

  ResultDiscover(results) {
    voteCount = results['vote_count'];
    id = results['id'];
    video = results['video'];
    voteAverage = results['vote_average'].toString();
    title = results['title'];
    popularity = results['popularity'].toString();
    posterPath = results['poster_path'] == null ? fakeImgPath : baseImageUrl+''+results['poster_path'];
    overview = results['overview'];
    releaseDate = results['release_date'];
    backdropPath = results['backdrop_path'] == null ? fakeImgPath : baseImageUrl+''+results['backdrop_path'];

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
