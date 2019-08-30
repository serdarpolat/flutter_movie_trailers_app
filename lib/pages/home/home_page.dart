import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/pages/home/now_playing_movies.dart';
import 'package:movie_traliers/pages/home/popular_movies.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class HomePage extends StatefulWidget {
  final AsyncSnapshot<ItemModel> snapshotItem;
  final AsyncSnapshot<ItemModel> snapshotPopular;
  final AsyncSnapshot<GenreModel> snapshotGenres;

  const HomePage(
      {Key key, this.snapshotItem, this.snapshotPopular, this.snapshotGenres})
      : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
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
                    header('Now Playing'),
                    NowPlayingMovies(
                      snapshotItem: widget.snapshotItem,
                      snapshotGenres: widget.snapshotGenres,
                    ),
                    header('Popular'),
                    PopularMovies(
                      snapshotGenres: widget.snapshotGenres,
                      snapshotPopular: widget.snapshotPopular,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
