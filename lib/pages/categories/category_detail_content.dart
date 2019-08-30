import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class CategoryDetailContent extends StatefulWidget {
  final ResultDiscover data;
  final String genres;
  final Widget videos;
  final Widget casts;

  const CategoryDetailContent(
      {Key key,
      this.data,
      this.genres,
      this.videos,
      this.casts})
      : super(key: key);
  @override
  _CategoryDetailContentState createState() => _CategoryDetailContentState();
}

class _CategoryDetailContentState extends State<CategoryDetailContent> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(
            'DETAILS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.4,
              color: accentColor,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              EvaIcons.arrowBack,
              color: accentColor,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(EvaIcons.heartOutline),
              color: accentColor,
            ),
          ],
          floating: true,
          elevation: 16,
          centerTitle: true,
          backgroundColor: bgColor,
          expandedHeight: screenSize.height * 0.65,
          pinned: true,
          snap: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: widget.data.posterPath,
              child: Container(
                width: screenSize.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      widget.data.posterPath,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              bgColor,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 24),
            Material(
              color: Colors.transparent,
              child: Container(
                width: screenSize.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white54, width: 1.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'TMDB',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.data.voteAverage,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: screenSize.width - 72,
                              child: Text(
                                widget.data.title,
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(EvaIcons.bookmarkOutline,
                                color: Colors.white54),
                          ],
                        ),
                      ),
                      Text(
                        widget.genres,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                      detailsPageHeader('Story'),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Text(
                          widget.data.overview,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      detailsPageHeader('Videos'),
                      widget.videos,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          detailsPageHeader('Casts'),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, right: 24),
                            child: Text(
                              'Full Casts',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget.casts,
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ]),
        ),
      ],
    );
  }
}