

import 'chapters.dart';

class Comic{
  dynamic category, name, image, author;
  List<Chapters>? chapters;

  Comic({this.category, this.chapters, this.name, this.image, this.author});

  Comic.fromJson(Map<String, dynamic> json)
  {
    category = json["Category"];
    if (json['Chapters'] != null) {
      chapters = <Chapters>[];
      json['Chapters'].forEach((element) {
        chapters!.add(Chapters.fromJson(element));
      });
    }
    image = json['Image'];
    name = json['Name'];
    author = json['Author'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Category'] = category;
    if(chapters!=null){
      data['Chapters'] = chapters!.map((e) => e.toJson()).toList();
    }
    data['Image'] = image;
    data['Name'] = name;
    data['Author'] = author;
    return data;
  }
}