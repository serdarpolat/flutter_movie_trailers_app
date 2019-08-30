import 'package:http/http.dart' show Client;
import 'package:movie_traliers/model/credits_model.dart';
import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'dart:convert';

import 'package:movie_traliers/model/trailer_model.dart';

final nowPlayingUrl =
    'https://api.themoviedb.org/3/movie/now_playing/?api_key=';
final popularUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=';
final baseUrl = 'https://api.themoviedb.org/3/movie/';
final genresUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=';
final apiKey = '1bb6d4935d683e27f590016db6031abe';
final baseImageUrl = 'https://image.tmdb.org/t/p/w500/';
final creditsUrl = 'https://api.themoviedb.org/3/movie/'; //420818/credits?api_key=


class MovieApiProvider {
  Client client = Client();

  Future<ItemModel> fetchNowPlayingMovieList(bool isPopular) async {
    final response = await client.get('$nowPlayingUrl$apiKey');

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body), isPopular);
    } else {
      throw Exception('Failed to load new movies');
    }
  }

  Future<ItemModel> fetchPopularMovieList(bool isPopular) async {
    final response = await client.get('$popularUrl$apiKey');

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body), isPopular);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<GenreModel> fetchGenreList() async {
    final response = await client.get('$genresUrl$apiKey');

    if (response.statusCode == 200) {
      return GenreModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<TrailerModel> fetchTrailers(int movieId) async {
    final response = await client.get("$baseUrl$movieId/videos?api_key=$apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<CreditsModel> fetchCredits(int movieId) async {
    final response = await client.get("$baseUrl$movieId/credits?api_key=$apiKey");
    print(response.body.toString());
    if (response.statusCode == 200) {
      return CreditsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<DiscoverModel> fetchMovieByGenre(String genreId) async {
    final response = await client.get('https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc&page_1&with_genres=$genreId');

    if (response.statusCode == 200) {
      return DiscoverModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load discover movies');
    }
  }
}
