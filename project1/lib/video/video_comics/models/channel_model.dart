
import 'package:project1/video/video_comics/models/video_model.dart';

class Channel {
   final String id;
   final String videoCount;
   final String upLoadPlayList;

  late List<Video> videos;

  Channel({
    required this.id,
    required this.videoCount,
    required this.upLoadPlayList
  });

  factory Channel.fromMap(Map<String, dynamic> map)=> Channel(
        id: map['id'],
        videoCount: map['statistics']['videoCount'],
        upLoadPlayList: map['contentDetails']['relatedPlaylists']['uploads']);
}