import 'package:flutter/material.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/pages/home/items_load.dart';
import 'package:movie_traliers/ui/loader.dart';
import 'package:movie_traliers/ui/theme_ui.dart';
import 'package:rxdart/rxdart.dart';

class GetMovies extends StatefulWidget {
  final dynamic itemType;
  final Observable<ItemModel> itemModel;
  final String header;
  final int id;

  const GetMovies({Key key, this.itemType, this.itemModel, this.header, this.id})
      : super(key: key);
  @override
  _GetMoviesState createState() => _GetMoviesState();
}

class _GetMoviesState extends State<GetMovies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        header(widget.header, true),
        StreamBuilder(
          stream: widget.itemModel,
          builder: (context, AsyncSnapshot<ItemModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 540,
                child: ItemsLoad(
                  snapshot: snapshot,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Loader(),
              ));
            }
          },
        ),
      ],
    );
  }
}
