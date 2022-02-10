import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project1/Nav/drawer.dart';
import 'package:project1/comics/controller/state_controller.dart';
import 'package:project1/comics/model/comic.dart';
import 'package:project1/comics/view/chapter_views.dart';

class HomeViews_Comics extends StatefulWidget {
  HomeViews_Comics({Key? key,this.app}) : super(key: key);

  final FirebaseApp? app;

  @override
  State<HomeViews_Comics> createState() => _HomeViews_ComicsState();
}

class _HomeViews_ComicsState extends State<HomeViews_Comics> {

  late DatabaseReference _bannerRef, _comicRef;
  bool isSearch = true;
  List<Comic> listComicFromFirebase = <Comic>[];

  Widget title_Comics = const Text("Comics", style: TextStyle(
      color: Colors.white,
      fontFamily: "Roboto_bold",
      fontSize: 25
  ),);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase _database = FirebaseDatabase(app: widget.app);
    _bannerRef = _database.reference().child("Banners");
    _comicRef = _database.reference().child("Comic");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer_nav(),
      appBar: AppBar(
        toolbarHeight: 60,
        actions: [
          IconButton(
              onPressed: ()=> setState(() {
                if(isSearch){
                  title_Comics = TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: const InputDecoration(
                          hintText: "Comic's name or category",
                          hintStyle: TextStyle (color: Colors.white60),
                        ),
                        autofocus: true,
                        style: DefaultTextStyle.of(context).style.
                        copyWith(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.white),
                      ),
                      suggestionsCallback: (searchString) async {
                        return searchComic(searchString);
                      },
                      itemBuilder: (context, Comic comic){
                        return ListTile(
                          leading: Image.network(comic.image),
                          title:  Text("${comic.name}"),
                          subtitle: Text("${comic.category}"),
                        );
                      },
                      onSuggestionSelected:(Comic comic){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ChapterViews(
                              comic: comic,
                            )));
                      });
                  isSearch = !isSearch;
                } else{
                  isSearch = !isSearch;
                  title_Comics = const Text("Comics", style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto_bold",
                      fontSize: 25
                  ),);
                }
              }),
              icon: const Icon(Icons.search)) //Search
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:[Colors.red, Colors.purple],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        title: title_Comics,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder<List<String>> (
        future: getBanners(_bannerRef),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                    items: snapshot.data!.map((e) => Builder(
                      builder: (context){
                        return Image.network(e, fit: BoxFit.cover,);
                      },
                    )).toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        initialPage: 0,
                        autoPlayAnimationDuration: const Duration(seconds: 3),
                        height: MediaQuery.of(context).size.height/3
                )),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors:[Colors.red, Colors.purple],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("NEW COMICS",
                            style: TextStyle(color: Colors.white, fontFamily: "Roboto_regu",),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.black,
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(""),
                        ),
                      ),
                    )
                  ],
                ),
                FutureBuilder(
                    future: getComics(_comicRef),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Center(
                            child: Text("${snapshot.error}",)
                        );
                      }
                      else if(snapshot.hasData){
                        listComicFromFirebase  = <Comic>[];
                        (snapshot.data as List).forEach((item){
                          var comic =
                           Comic.fromJson(json.decode(json.encode(item)));
                          listComicFromFirebase.add(comic);
                        });
                        return Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              padding: const EdgeInsets.all(4),
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 1.0,
                              children: listComicFromFirebase.map((comic){
                                return GestureDetector(
                                  onTap: (){
                                     Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ChapterViews(
                                        comic: comic,
                                    )));
                                  },
                                  child: Card(
                                    elevation: 12,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(comic.image, fit: BoxFit.cover,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              color: Colors.black38,
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text('${comic.name}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                        );
                      }
                      return const Center(child: CircularProgressIndicator(),);
                    })
              ],
            );
          } else if(snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
            return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Future<List<Comic>> searchComic(String searchString) async {
    return listComicFromFirebase.where((comic) =>
      comic.name.toString().toLowerCase().contains(searchString.toLowerCase())
        ||
          (comic.category != null && comic.category.toString().toLowerCase().contains(searchString.toLowerCase()))
    ).toList();
  }

}


