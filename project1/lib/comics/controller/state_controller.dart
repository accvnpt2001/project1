import 'package:firebase_database/firebase_database.dart';

Future<List<dynamic>> getComics(DatabaseReference comicRef) {
  return comicRef.once().then((snapshot) =>
  snapshot.value);
}

Future<List<String>> getBanners(DatabaseReference bannerRef) {
  return bannerRef.once().then((snapshot) =>
      snapshot.value.cast<String>().toList());
}