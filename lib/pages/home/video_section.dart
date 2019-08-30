import 'package:flutter/material.dart';
import 'package:movie_traliers/model/trailer_model.dart';
import 'package:movie_traliers/pages/video_player.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class VideoSection extends StatefulWidget {
  final int videosLength;
  final String posterPath;
  final AsyncSnapshot<TrailerModel> snapshotTrailer;

  const VideoSection(
      {Key key, this.videosLength, this.posterPath, this.snapshotTrailer})
      : super(key: key);
  @override
  _VideoSectionState createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 24),
      child: widget.videosLength > 0
          ? Container(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List<Widget>.generate(
                    widget.videosLength > 4 ? 4 : widget.videosLength, (index) {
                  var data = widget.snapshotTrailer.data.results[index];
                  return Container(
                    width: (size.width - 58) / 2,
                    height: (size.width - 58) / 2 * 3 / 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.posterPath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.7),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerPage(
                                      source: data.key,
                                    ),
                                  ));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: accentColor, width: 1),
                                color: Colors.white12,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          : Text('No Videos Found'),
    );
  }
}
