
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project1/video/video_comics/controller/concern_data.dart';
import 'package:project1/video/video_comics/models/concern_comic_model.dart';
import 'package:project1/video/video_comics/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final Video video;
  final String id;

  VideoScreen({required this.id, required this.video});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<ConcernComic> concern = <ConcernComic>[];
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    concern = getComics();
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                color: Colors.white,
                child: Image.network("https://ss-images.saostar.vn/wwebp700/2019/09/15/6049331/batman-dc-comics.jpg", fit: BoxFit.cover,),
              ),
              clipper: CustomClipPath(),
            ),
            Text(widget.video.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: "Roboto_bold"),
            ),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {},
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.add_alert, size: 30, color: Colors.white,),
                Icon(Icons.add, size: 30, color: Colors.white),
                Icon(Icons.play_arrow, size: 30, color: Colors.white)
              ],
            ),
            const SizedBox(height: 10,),
            const Divider(height: 5, color: Colors.white, thickness: 2,),
            const Text("Concern Comic", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Roboto_bold"),),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: concern.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Container(
                      margin: const EdgeInsets.all(10),
                      width: 120,
                      height: 200,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: Image.asset(concern[index].imageUrl, fit: BoxFit.cover,)),
                          Text(concern[index].categoryName, style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Roboto_bold"
                          ),),
                        ],
                      ),
                    );
                  }),
            ),
            const Divider(height: 5, color: Colors.white, thickness: 2,),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(left: 20),
              width: 150,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
              child: const Center(child: Text("Description", style: TextStyle(fontSize: 20),)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration:  BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.video.description, style: TextStyle(fontSize: 15, color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height,
        size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}