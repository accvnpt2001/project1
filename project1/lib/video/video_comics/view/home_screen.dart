import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project1/nav/widgets.dart';
import 'package:project1/video/video_comics/controller/concern_data.dart';
import 'package:project1/video/video_comics/models/channel_model.dart';
import 'package:project1/video/video_comics/models/concern_comic_model.dart';
import 'package:project1/video/video_comics/models/video_model.dart';
import 'package:project1/video/video_comics/view/video_screen.dart';
import 'package:project1/video/video_comics/controller/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Channel _channel;
  bool _isLoading = false;
  bool _loadPage = true;


  @override
  void initState() {
    super.initState();
    _initChannel().whenComplete((){
      setState(() {
        _loadPage = false;
      });
    });
  }

   _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCYVyGzQK0DUNGUHqinZqw8g');
    setState(() {
      _channel = channel;
    });
  }

  _buildVideo(Video video) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      padding: const EdgeInsets.all(10.0),
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        border: Border.all(color: Colors.white)
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
        Column(
          children: <Widget>[
            Image(
              image: NetworkImage(video.thumbnailUrl),
            ),
            const SizedBox(width: 10.0),
            Text(
              video.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: "Roboto_bold"
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
         Positioned(
            bottom: -30,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoScreen(id: video.id, video: video,),
                ),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 29,
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.red,
                  child: Icon(
                      Icons.play_arrow, color: Colors.white, size: 35,),
                ),
              ),
            ))
      ],)
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.upLoadPlayList);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _loadPage
            ? const Center(child: CircularProgressIndicator(),)
            : NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollDetails) {
            if (!_isLoading &&
                _channel.videos.length != int.parse(_channel.videoCount) &&
                scrollDetails.metrics.pixels ==
                    scrollDetails.metrics.maxScrollExtent) {
              _loadMoreVideos();
            }
            return false;
          },
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("image/wood.jfif"),
                        fit: BoxFit.cover)
                  ),
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: "https://nerdreactor.com/wp-content/uploads/2014/06/Marvel1-600x390.jpg", width: double.infinity, height: 80,  fit: BoxFit.cover,)
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          width: double.infinity,
                          height: 80,
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black54,
                            border: Border.all(color: Colors.red.shade900)
                          ),
                          child: const Text("Coffee Comic", style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 25,
                            fontFamily: "Roboto_bold",
                          ),),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _channel.videos.length,
                        itemBuilder: (context, index) {
                          Video video = _channel.videos[index];
                          return _buildVideo(video);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }

}