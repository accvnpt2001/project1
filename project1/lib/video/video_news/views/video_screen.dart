
import 'package:flutter/material.dart';
import 'package:project1/Nav/widgets.dart';
import 'package:project1/video/video_news/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final Video video;
  final String id;

  VideoScreen({required this.id, required this.video});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: subAppBar("Have a great days!"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red[900],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.video.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Roboto_bold'),),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(height: 15, width: 20, color: Colors.grey[800],),
                Container(height: 15, width: 20, color: Colors.grey[800],),
              ],
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[800]
              ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.video.description,
                  style: const TextStyle(fontSize: 17, color: Colors.white),),
                )
            )
          ],
        ),
      ),
    );
  }
}