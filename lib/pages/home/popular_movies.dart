import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/pages/home/movie_details.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class PopularMovies extends StatefulWidget {
  final AsyncSnapshot<GenreModel> snapshotGenres;
  final AsyncSnapshot<ItemModel> snapshotPopular;

  PopularMovies({this.snapshotGenres, this.snapshotPopular});
  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PopularMovieItem(
            snapshotGenres: widget.snapshotGenres,
            snapshotPopular: widget.snapshotPopular,
            index: 0,
          ),
          PopularMovieItem(
            snapshotGenres: widget.snapshotGenres,
            snapshotPopular: widget.snapshotPopular,
            index: 1,
          ),
          PopularMovieItem(
            snapshotGenres: widget.snapshotGenres,
            snapshotPopular: widget.snapshotPopular,
            index: 2,
          ),
          PopularMovieItem(
            snapshotGenres: widget.snapshotGenres,
            snapshotPopular: widget.snapshotPopular,
            index: 3,
          ),
          PopularMovieItem(
            snapshotGenres: widget.snapshotGenres,
            snapshotPopular: widget.snapshotPopular,
            index: 4,
          ),
        ],
      ),
    );
  }
}

class PopularMovieItem extends StatefulWidget {
  final AsyncSnapshot<GenreModel> snapshotGenres;
  final AsyncSnapshot<ItemModel> snapshotPopular;
  final int index;

  const PopularMovieItem(
      {Key key, this.snapshotGenres, this.snapshotPopular, this.index})
      : super(key: key);
  @override
  _PopularMovieItemState createState() => _PopularMovieItemState();
}

class _PopularMovieItemState extends State<PopularMovieItem> {
  @override
  Widget build(BuildContext context) {
    var data = widget.snapshotPopular.data.results[widget.index];
    DateTime releaseDate = DateTime.parse(data.releaseDate);
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String formattedDate = dateFormat.format(releaseDate);
    String genres = widget.snapshotGenres.data
        .getGenre(widget.snapshotPopular.data.results[widget.index].genreIds);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(24, 0, 24, 20),
      height: 264,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetail(
                data: widget.snapshotPopular.data.results[widget.index],
                isPopular: true,
                genres: genres,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Hero(
              tag: data.posterPath,
              child: Container(
                width: 160,
                height: 264,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(data.posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 208,
              padding: EdgeInsets.only(left: 24, top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    data.title,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    genres,
                    style: TextStyle(color: Colors.white30, fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.red.withOpacity(0.8),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: data.voteAverage.toString() + '/',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '10',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
