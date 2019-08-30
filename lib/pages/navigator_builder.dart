import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_traliers/bloc/genres_bloc.dart';
import 'package:movie_traliers/bloc/movies_bloc.dart';
import 'package:movie_traliers/bloc/popular_movies_bloc.dart';
import 'package:movie_traliers/model/genre_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/pages/categories/categories_page.dart';
import 'package:movie_traliers/pages/home/home_page.dart';
import 'package:movie_traliers/pages/home_app_bar.dart';
import 'package:movie_traliers/pages/user_page.dart';
import 'package:movie_traliers/pages/videos_page.dart';
import 'package:movie_traliers/ui/loader.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class Stream1 extends StatefulWidget {
  @override
  _Stream1State createState() => _Stream1State();
}

class _Stream1State extends State<Stream1> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.allNowPlayingMovies,
      builder: (context, AsyncSnapshot<ItemModel> snapshotItem) {
        if (snapshotItem.hasData) {
          return Stream2(snapshotItem: snapshotItem);
        } else if (snapshotItem.hasError) {
          throw Exception('HATA 1 : ${snapshotItem.error}');
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: bgColor,
            child: Center(
              child: Loader(),
            ),
          );
        }
      },
    );
  }
}

class Stream2 extends StatefulWidget {
  final AsyncSnapshot<ItemModel> snapshotItem;

  const Stream2({Key key, this.snapshotItem}) : super(key: key);
  @override
  _Stream2State createState() => _Stream2State();
}

class _Stream2State extends State<Stream2> {
  @override
  void initState() {
    super.initState();
    blocPopular.fetchAllPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocPopular.allPopularMovies,
      builder: (context, AsyncSnapshot<ItemModel> snapshotPopular) {
        if (snapshotPopular.hasData) {
          return Stream3(
            snapshotPopular: snapshotPopular,
            snapshotItem: widget.snapshotItem,
          );
        } else if (snapshotPopular.hasError) {
          throw Exception('HATA 2 : ${snapshotPopular.error}');
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: bgColor,
          );
        }
      },
    );
  }
}

class Stream3 extends StatefulWidget {
  final AsyncSnapshot<ItemModel> snapshotItem;
  final AsyncSnapshot<ItemModel> snapshotPopular;

  const Stream3({Key key, this.snapshotPopular, this.snapshotItem})
      : super(key: key);
  @override
  _Stream3State createState() => _Stream3State();
}

class _Stream3State extends State<Stream3> {
  @override
  void initState() {
    super.initState();
    blocGenres.fetchAllGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocGenres.allGenres,
      builder: (context, AsyncSnapshot<GenreModel> snapshotGenres) {
        if (snapshotGenres.hasData) {
          return NavigatorBuilder(
            snapshotItem: widget.snapshotItem,
            snapshotPopular: widget.snapshotPopular,
            snapshotGenres: snapshotGenres,
          );
        } else if (snapshotGenres.hasError) {
          throw Exception('HATA 3 : ${snapshotGenres.error}');
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: bgColor,
          );
        }
      },
    );
  }
}

class NavigatorBuilder extends StatefulWidget {
  final AsyncSnapshot<ItemModel> snapshotItem;
  final AsyncSnapshot<ItemModel> snapshotPopular;
  final AsyncSnapshot<GenreModel> snapshotGenres;

  const NavigatorBuilder(
      {Key key, this.snapshotItem, this.snapshotPopular, this.snapshotGenres})
      : super(key: key);
  @override
  _NavigatorBuilderState createState() => _NavigatorBuilderState();
}

class _NavigatorBuilderState extends State<NavigatorBuilder> {
  int bottomSelectedIndex = 0;
  int selectedIndex = 0;

  List<NavItem> items = [
    NavItem(
      Icon(EvaIcons.homeOutline, color: accentColor),
      Text('Trending',
          style: TextStyle(color: bgColor, fontWeight: FontWeight.bold)),
      0,
    ),
    NavItem(
      Icon(EvaIcons.filmOutline, color: accentColor),
      Text('Category',
          style: TextStyle(color: bgColor, fontWeight: FontWeight.bold)),
      1,
    ),
    NavItem(
      Icon(EvaIcons.bellOutline, color: accentColor),
      Text('Videos',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      2,
    ),
    NavItem(
      Icon(EvaIcons.videoOutline, color: accentColor),
      Text('User',
          style: TextStyle(color: bgColor, fontWeight: FontWeight.bold)),
      3,
    ),
  ];

  Widget buildNavItems(NavItem item, bool isSelected) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
        width: MediaQuery.of(context).size.width / 4 - 20,
        height: double.maxFinite,
        color: isSelected ? accentColor : Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              bottom: -18.0 * (isSelected ? 1.0 : 5.0),
              child: Container(
                child: item.title,
                height: 46,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              top: -5.0 * (isSelected ? 10.0 : 1.0),
              left: 28,
              child: Container(
                child: item.icon,
                height: 46,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              pageChanged(index);
            },
            children: <Widget>[
              HomePage(
                snapshotItem: widget.snapshotItem,
                snapshotPopular: widget.snapshotPopular,
                snapshotGenres: widget.snapshotGenres,
              ),
              CategoriesPage(
                snapshotGenres: widget.snapshotGenres,
                snapshotItem: widget.snapshotItem,
              ),
              VideosPage(),
              UserPage(),
            ],
          ),
          HomeAppBar(),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 72,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            var itemIndex = items.indexOf(item);
            return GestureDetector(
              onTap: () {
                setState(() {
                  bottomSelectedIndex = itemIndex;
                  pageController.animateToPage(itemIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                });
                print(bottomSelectedIndex);
              },
              child: buildNavItems(item, bottomSelectedIndex == itemIndex),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavItem {
  final Icon icon;
  final Text title;
  final int index;

  const NavItem(this.icon, this.title, this.index);
}
