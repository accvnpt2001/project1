import 'package:flutter/material.dart';
import 'package:project1/nav/nav_comic.dart';

import 'nav_news.dart';

class Drawer_nav extends StatefulWidget {
  const Drawer_nav({Key? key}) : super(key: key);

  @override
  _Drawer_navState createState() => _Drawer_navState();
}

class _Drawer_navState extends State<Drawer_nav> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("image/logo.png"),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const NavNews()));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Stack(
                    children: [
                      const Image(
                          image: AssetImage("image/news.jfif"),
                          width: double.infinity, height: 120,
                          fit: BoxFit.cover
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: double.infinity, height: 120,
                        color: Colors.black26,
                        child: const Text("News", style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 30,
                          fontFamily: "Roboto_bold",
                        ),),
                      )
                    ],
                  ),
                )
              ),
              const SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const NavComic()));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Stack(
                    children: [
                      const Image(
                          image: AssetImage("image/comics.jfif"),
                          width: double.infinity, height: 120,
                          fit: BoxFit.cover
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: double.infinity, height: 120,
                        color: Colors.black26,
                        child: const Text("Comics", style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 30,
                          fontFamily: "Roboto_bold",
                        ),),
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
