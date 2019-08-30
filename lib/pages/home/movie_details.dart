import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_traliers/bloc/credits_bloc.dart';
import 'package:movie_traliers/bloc/trailer_bloc.dart';
import 'package:movie_traliers/model/credits_model.dart';
import 'package:movie_traliers/model/item_model.dart';
import 'package:movie_traliers/model/trailer_model.dart';
import 'package:movie_traliers/pages/home/cast_section.dart';
import 'package:movie_traliers/pages/home/detail_content.dart';
import 'package:movie_traliers/pages/home/video_section.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class MovieDetail extends StatefulWidget {
  final Result data;
  final bool isPopular;
  final String genres;
  final Cast creditsData;

  const MovieDetail(
      {Key key, this.data, this.isPopular, this.genres, this.creditsData})
      : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
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
        body: DetailContent(
          data: widget.data,
          isPopular: widget.isPopular,
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
