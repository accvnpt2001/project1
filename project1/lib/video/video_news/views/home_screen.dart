import 'package:flutter/material.dart';
import 'package:project1/video/video_news/models/channel_model.dart';
import 'package:project1/video/video_news/models/video_model.dart';
import 'package:project1/video/video_news/views/video_screen.dart';
import 'package:project1/video/video_news/controller/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        .fetchChannel(channelId: 'UCabsTV34JwALXKGMqHpvUiA');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      height: 100.0,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePicture),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              _channel.title,
              style: const TextStyle(
                letterSpacing: 1,
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: "Roboto_bold"
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(id: video.id, video: video,),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            padding: const EdgeInsets.all(10.0),
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 1),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(video.thumbnailUrl),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    video.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(video.publishedAt),
        )
      ],
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
    return Scaffold(
      backgroundColor: Colors.white,
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
          child: ListView.builder(
          itemCount: 1 + _channel.videos.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileInfo(),
                  const Divider(
                    thickness: 2,
                    height: 5,
                    color: Colors.red,
                    endIndent: 50,
                    indent: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                    child: const Text("New Videos", style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Roboto_bold"
                    ),),
                  ),
                ],
              );
            }
            Video video = _channel.videos[index - 1];
            return Column(
              children: [
                _buildVideo(video),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                  endIndent: 50,
                  indent: 50,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}