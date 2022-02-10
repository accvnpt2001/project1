
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/nav/widgets.dart';
import 'package:project1/comics/model/comic.dart';
import 'package:project1/comics/view/read_views.dart';


class ChapterViews extends StatelessWidget {
  const ChapterViews({Key? key, required this.comic}) : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: subAppBar("${comic.name}"),
        body: comic.chapters != null && comic.chapters!.isNotEmpty
        ? Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: const DecorationImage(
                      image: AssetImage("image/backgroundchapter.jpg"),
                      alignment: Alignment.topRight,
                    fit: BoxFit.fitWidth,
                  )
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height/3.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(comic.image)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person),
                            Text(" Author: ${comic.author}", style: const TextStyle(fontFamily: "Roboto_bold", fontSize: 15, color: Colors.black54),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Icon(Icons.category),
                            Text(" Category: ${comic.category}", style: const TextStyle(fontFamily: "Roboto_bold", fontSize: 15, color: Colors.black54),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: const [
                            Icon(Icons.wifi),
                            Text(" Status: Completed", style: TextStyle(fontFamily: "Roboto_bold", fontSize: 15, color: Colors.black54),),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ReadViews(
                                  chapters: comic.chapters![0],
                                )));
                          },
                          child: ChooseChapter("First Chapter"),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ReadViews(
                                  chapters: comic.chapters![comic.chapters!.length-1],
                                )));
                          },
                          child: ChooseChapter("Last Chapter"),
                        )
                      ],
                    ),
                    const SizedBox(width: 5,)
                  ],
                ),
              ),
              const Divider(thickness: 5, color: Colors.orange, endIndent: 100,),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: comic.chapters!.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ReadViews(
                                    chapters: comic.chapters![index],
                                  )));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("${comic.chapters![index].name}",
                                    style: const TextStyle(fontFamily: "Roboto_bold", fontSize: 17),
                                  ),
                                ),
                                const Divider(thickness: 1,)
                              ],
                            ),
                          );
                        }),
              ),
            ],
          )
        ):const Center(
          child: Text("We are translating this comic", style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}
