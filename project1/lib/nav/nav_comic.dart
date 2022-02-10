import 'package:flutter/material.dart';
import 'package:project1/comics/view/home_views_comic.dart';
import 'package:project1/nav/widgets.dart';
import 'package:project1/video/video_comics/view/home_screen.dart';

class NavComic extends StatefulWidget {
  const NavComic({Key? key}) : super(key: key);


  @override
  _NavComicState createState() => _NavComicState();
}

class _NavComicState extends State<NavComic> {
  Widget a = HomeViews_Comics();
  Widget b = HomeScreen();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          bottomNavigatorItem(Icons.auto_stories,),
          bottomNavigatorItem(Icons.ondemand_video,),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index)  {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getBody( )  {
    if(selectedIndex == 0) {
      return a;
    } else {
      return b;
    }
  }
}
