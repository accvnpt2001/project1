import 'package:project1/video/video_comics/models/concern_comic_model.dart';

List<ConcernComic> getComics() {
  List<ConcernComic> concern = <ConcernComic>[];
  ConcernComic concernModel = ConcernComic();

  concernModel = ConcernComic();
  concernModel.categoryName = "Batman";
  concernModel.imageUrl = "image/Batman_Lee.png";
  concern.add(concernModel);

  concernModel = ConcernComic();
  concernModel.categoryName = "Superman";
  concernModel.imageUrl = "image/superman.jpg";
  concern.add(concernModel);

  concernModel = ConcernComic();
  concernModel.categoryName = "Spider-Man";
  concernModel.imageUrl = "image/spider.jpg";
  concern.add(concernModel);

  concernModel = ConcernComic();
  concernModel.categoryName = "The Flash";
  concernModel.imageUrl = "image/flash.jpg";
  concern.add(concernModel);


  return concern;
}