import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_traliers/model/item_model.dart';

class ItemsLoad extends StatefulWidget {
  final AsyncSnapshot<ItemModel> snapshot;

  ItemsLoad({this.snapshot});

  @override
  _ItemsLoadState createState() => _ItemsLoadState();
}

class _ItemsLoadState extends State<ItemsLoad> {
  String preImageLink = 'https://image.tmdb.org/t/p/w500/';
  @override
  Widget build(BuildContext context) {
    var data = widget.snapshot.data.results;
    return CarouselSlider(
      viewportFraction: 0.90,
      realPage: data.length,
      enableInfiniteScroll: false,
      reverse: false,
      enlargeCenterPage: true,
      height: 540,
      items: data.map((result) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(preImageLink + '' + result.posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}