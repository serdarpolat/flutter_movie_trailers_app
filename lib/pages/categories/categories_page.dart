import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/pages/categories/category_list.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class CategoriesPage extends StatefulWidget {
  final AsyncSnapshot<GenreModel> snapshotGenres;
  final AsyncSnapshot<ItemModel> snapshotItem;

  const CategoriesPage({Key key, this.snapshotGenres, this.snapshotItem}) : super(key: key);
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> imgPaths = [
    'assets/images/action_ct.jpg',
    'assets/images/adventure_ct.jpg',
    'assets/images/animation_ct.jpg',
    'assets/images/comedy_ct.jpg',
    'assets/images/crime_ct.jpg',
    'assets/images/documentary_ct.jpg',
    'assets/images/drama_ct.jpg',
    'assets/images/family_ct.jpg',
    'assets/images/fantasy_ct.jpg',
    'assets/images/history_ct.jpg',
    'assets/images/horror_ct.jpg',
    'assets/images/music_ct.png',
    'assets/images/mystery_ct.jpg',
    'assets/images/romance_ct.jpg',
    'assets/images/sci_fi_ct.jpg',
    'assets/images/tv_movies_ct.jpg',
    'assets/images/thriller_ct.jpg',
    'assets/images/war_ct.jpg',
    'assets/images/western_ct.jpg'
  ];

  List<Color> bgColors = [
    // Darkmuted Colors
    Color(0xff121319),
    Color(0xff586035),
    Color(0xff171527),
    Color(0xff5c5c76),
    Color(0xff0c1019),
    Color(0xff423b3b),
    Color(0xff180e13),
    Color(0xff623736),
    Color(0xff263b4a),
    Color(0xff2d333d),
    Color(0xff464541),
    Color(0xff483052),
    Color(0xff1c333f),
    Color(0xff122320),
    Color(0xff162026),
    Color(0xff1d1d14),
    Color(0xff67673f),
    Color(0xff4f5235),
    Color(0xff5a3e3f),

    // Lightmuted Colors
    // Color(0xffb8bdc2),
    // Color(0xffcfc7a4),
    // Color(0xffceb7bb),
    // Color(0xfff0efe6),
    // Color(0xffa1a3aa),
    // Color(0xffb7b6b1),
    // Color(0xffb7a9a7),
    // Color(0xff7eb9bf),
    // Color(0xff9cbfc7),
    // Color(0xffbabfc1),
    // Color(0xffc1c2bb),
    // Color(0xffa6b5cd),
    // Color(0xffc7dede),
    // Color(0xffa6ae9d),
    // Color(0xffbfcccf),
    // Color(0xffb8baba),
    // Color(0xffc9ca9b),
    // Color(0xffb7a36c),
    // Color(0xffcfb1b1),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    GenreModel data = widget.snapshotGenres.data;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          width: screenSize.width,
          // height: screenSize.height,
          padding: EdgeInsets.only(top: 124, left: 24, right: 24, bottom: 24),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              children: List<Widget>.generate(data.genres.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryList(
                          genreId: data.genres[index].getId.toString(),
                        ),
                      ),
                    );
                    print(data.genres[index].getId.toString());
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: (screenSize.width - 68) / 2,
                        height: (screenSize.width - 68) / 2 * (3 / 4),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imgPaths[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Container(
                        width: (screenSize.width - 68) / 2,
                        height: (screenSize.width - 68) / 2 * (3 / 4),
                        decoration: BoxDecoration(
                          color: bgColors[index].withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            data.genres[index].getName,
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
