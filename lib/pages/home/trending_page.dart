import 'package:flutter/material.dart';
import 'package:movie_traliers/bloc/genres_bloc.dart';
import 'package:movie_traliers/bloc/movies_bloc.dart';
import 'package:movie_traliers/bloc/popular_movies_bloc.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/pages/home/now_playing_movies.dart';
import 'package:movie_traliers/pages/home/popular_movies.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class TrendingPage extends StatefulWidget {
  final AsyncSnapshot<ItemModel> snapshotItem;
  final AsyncSnapshot<ItemModel> snapshotPopular;
  final AsyncSnapshot<GenreModel> snapshotGenres;

  const TrendingPage(
      {Key key, this.snapshotItem, this.snapshotPopular, this.snapshotGenres})
      : super(key: key);

  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllNowPlayingMovies();
    blocPopular.fetchAllPopularMovies();
    blocGenres.fetchAllGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 90),
            color: bgColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // HomeAppBar(),
                header('Now Playing', true),
                NowPlayingMovies(
                  snapshotItem: widget.snapshotItem,
                  snapshotGenres: widget.snapshotGenres,
                ),
                header('Popular', true),
                PopularMovies(
                  snapshotGenres: widget.snapshotGenres,
                  snapshotPopular: widget.snapshotPopular,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
