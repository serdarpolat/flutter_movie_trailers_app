import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String source;
  VideoPlayerPage({Key key, this.source}) : super(key: key);

  // final String title;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController videoController;
  // String _source = "4CbLXeGSDxg";
  bool isMute = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          context: context,
          source: widget.source,
          quality: YoutubeQuality.HD,
          aspectRatio: 16 / 9,
          autoPlay: true,
          loop: false,
          reactToOrientationChange: true,
          startFullScreen: false,
          controlsActiveBackgroundOverlay: true,
          controlsTimeOut: Duration(seconds: 4),
          playerMode: YoutubePlayerMode.DEFAULT,
          callbackController: (controller) {
            videoController = controller;
          },
        ),
      ),
    );
  }
}
