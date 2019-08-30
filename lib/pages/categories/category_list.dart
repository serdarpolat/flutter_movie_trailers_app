import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_traliers/bloc/discover_bloc.dart';
import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/pages/categories/category_movie_detail.dart';
import 'package:movie_traliers/ui/loader.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class CategoryList extends StatefulWidget {
  final AsyncSnapshot<GenreModel> snapshotGenres;
  final String genreId;
  final String headerText;

  const CategoryList(
      {Key key, this.genreId, this.snapshotGenres, this.headerText})
      : super(key: key);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool sortBy = true;

  @override
  void initState() {
    super.initState();
    blocDiscover.fetchAllDiscoverMovies(widget.genreId, sortBy);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: screenSize.width,
        height: double.maxFinite,
        child: StreamBuilder(
          stream: blocDiscover.allDiscoverMovies,
          builder: (context, AsyncSnapshot<DiscoverModel> snapshotDiscover) {
            if (snapshotDiscover.hasData) {
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 124),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Wrap(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 24.0, right: 24.0),
                            child: Wrap(
                              spacing: 15,
                              runSpacing: 20,
                              children: List<Widget>.generate(
                                  snapshotDiscover.data.results.length,
                                  (index) {
                                String genres = widget.snapshotGenres.data
                                    .getGenre(snapshotDiscover
                                        .data.results[index].genreIds);
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryMovieDetail(
                                            genres: genres,
                                            data: snapshotDiscover
                                                .data.results[index],
                                          ),
                                        ));
                                  },
                                  child: Hero(
                                    tag: snapshotDiscover
                                        .data.results[index].posterPath,
                                    child: Container(
                                      width: (screenSize.width - 68) / 2,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: (screenSize.width - 68) / 2,
                                            height: (screenSize.width - 68) /
                                                2 *
                                                (4 / 3),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    snapshotDiscover
                                                        .data
                                                        .results[index]
                                                        .posterPath),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    height: 96,
                    padding: EdgeInsets.only(left: 24, right: 24, top: 30),
                    decoration: BoxDecoration(
                      color: bgColor,
                      border: Border(
                        bottom: BorderSide(
                          width: 0.3,
                          color: accentColor,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(EvaIcons.arrowBackOutline),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 32,
                              color: accentColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.headerText + ' Movies',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshotDiscover.hasError) {
              throw Exception('HATA Discover : ${snapshotDiscover.error}');
            } else {
              return Center(
                child: Loader(),
              );
            }
          },
        ),
      ),
    );
  }
}
