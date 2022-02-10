import 'package:flutter/material.dart';
import 'package:project1/nav/widgets.dart';
import 'package:project1/news/views/home.dart';
import 'package:project1/video/video_news/views/home_screen.dart';

class NavNews extends StatefulWidget {
  const NavNews({Key? key}) : super(key: key);


  @override
  _NavNewsState createState() => _NavNewsState();
}

class _NavNewsState extends State<NavNews> {
  Widget a = const Home();
  Widget b = const HomeScreen();
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
          bottomNavigatorItem(Icons.library_books),
          bottomNavigatorItem(Icons.videocam),
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
