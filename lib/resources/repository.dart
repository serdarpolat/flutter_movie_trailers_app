import 'package:movie_traliers/model/credits_model.dart';
import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/model/trailer_model.dart';
import 'package:movie_traliers/resources/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchNowPlayingMovies() =>
      movieApiProvider.fetchNowPlayingMovieList(false);
  Future<ItemModel> fetchPopularMovies() =>
      movieApiProvider.fetchPopularMovieList(true);
  Future<GenreModel> fetchAllGenres() => movieApiProvider.fetchGenreList();
  Future<TrailerModel> fetchtrailers(int movieId) =>
      movieApiProvider.fetchTrailers(movieId);
  Future<CreditsModel> fetchcredits(int movieId) =>
      movieApiProvider.fetchCredits(movieId);
  Future<DiscoverModel> fetchAllDiscoverMovies(String genreId) =>
      movieApiProvider.fetchMovieByGenre(genreId);
}
