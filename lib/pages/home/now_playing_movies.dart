import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/pages/home/movie_details.dart';

class NowPlayingMovies extends StatefulWidget {
  final AsyncSnapshot<ItemModel> snapshotItem;
  final AsyncSnapshot<GenreModel> snapshotGenres;

  const NowPlayingMovies({Key key, this.snapshotItem, this.snapshotGenres})
      : super(key: key);
  @override
  _NowPlayingMoviesState createState() => _NowPlayingMoviesState();
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 460,
      child: CarouselSlider(
        viewportFraction: 0.85,
        realPage: widget.snapshotItem.data.results.length,
        enableInfiniteScroll: false,
        reverse: false,
        enlargeCenterPage: true,
        height: 460,
        items: widget.snapshotItem.data.results.map((result) {
          return Builder(
            builder: (BuildContext context) {
              String genres =
                  widget.snapshotGenres.data.getGenre(result.genreIds);
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetail(
                        data: result,
                        isPopular: false,
                        genres: genres,
                      ),
                    ),
                  );
                  print(result.getId);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 36.0),
                  child: Hero(
                    tag: result.id,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(result.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}