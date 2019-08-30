import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_traliers/bloc/credits_bloc.dart';
import 'package:movie_traliers/bloc/trailer_bloc.dart';
import 'package:movie_traliers/model/credits_model.dart';
import 'package:movie_traliers/model/discover_model.dart';
import 'package:movie_traliers/model/trailer_model.dart';
import 'package:movie_traliers/pages/categories/category_detail_content.dart';
import 'package:movie_traliers/pages/home/cast_section.dart';
import 'package:movie_traliers/pages/home/video_section.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class CategoryMovieDetail extends StatefulWidget {
  final ResultDiscover data;
  final String genres;
  final Cast creditsData;

  const CategoryMovieDetail(
      {Key key, this.data, this.genres, this.creditsData})
      : super(key: key);

  @override
  _CategoryMovieDetailState createState() => _CategoryMovieDetailState();
}

class _CategoryMovieDetailState extends State<CategoryMovieDetail> {
  int videoLen;

  @override
  void initState() {
    super.initState();
    blocTrailer.fetchAllTrailers(widget.data.id);
    blocCredit.fetchAllCredits(widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: CategoryDetailContent(
          data: widget.data,
          genres: widget.genres,
          videos: StreamBuilder(
            stream: blocTrailer.allTrailersOfMovie,
            builder: (context, AsyncSnapshot<TrailerModel> snapshotTrailer) {
              if (snapshotTrailer.hasData) {
                return VideoSection(
                  videosLength: snapshotTrailer.data.results.length,
                  posterPath: widget.data.posterPath,
                  snapshotTrailer: snapshotTrailer,
                );
              } else if (snapshotTrailer.hasError) {
                throw Exception('${snapshotTrailer.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          casts: StreamBuilder(
            stream: blocCredit.allCreditsOfMovie,
            builder: (context, AsyncSnapshot<CreditsModel> snapshotCredit) {
              if (snapshotCredit.hasData) {
                return CastSection(
                  snapshotCredit: snapshotCredit,
                );
              } else if (snapshotCredit.hasError) {
                throw Exception('Failed : ${snapshotCredit.error}');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
