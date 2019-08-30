import 'package:flutter/material.dart';
import 'package:movie_traliers/bloc/discover_bloc.dart';
import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/ui/loader.dart';

class CategoryList extends StatefulWidget {
  final AsyncSnapshot<GenreModel> snapshotGenres;
  final String genreId;

  const CategoryList({Key key, this.genreId, this.snapshotGenres}) : super(key: key);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  @override
  void initState() {
    super.initState();
    blocDiscover.fetchAllDiscoverMoviesMovies(widget.genreId);
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: double.maxFinite,
        child: StreamBuilder(
          stream: blocDiscover.allDiscoverMovies,
          builder: (context, AsyncSnapshot<DiscoverModel> snapshotDiscover) {
            if(snapshotDiscover.hasData){
              return ListView.builder(
                itemCount: snapshotDiscover.data.results.length,
                itemBuilder: (context, index) {
                  return Text(
                    snapshotDiscover.data.results[index].title,
                  );
                },
              );
            } else if(snapshotDiscover.hasError) {
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