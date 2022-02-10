
import 'package:project1/video/video_news/models/video_model.dart';

class Channel{
  final String id;
  final String title;
  final String profilePicture;
  final String videoCount;
  final String upLoadPlayList;

  late List<Video> videos;

  Channel({
    required this.id,
    required this.title,
    required this.profilePicture,
    required this.videoCount,
    required this.upLoadPlayList
  });

  factory Channel.fromMap(Map<String, dynamic> map)=> Channel(
        id: map['id'],
        title: map['snippet']['title'],
        profilePicture: map['snippet']['thumbnails']['default']['url'],
        videoCount: map['statistics']['videoCount'],
        upLoadPlayList: map['contentDetails']['relatedPlaylists']['uploads']);
}