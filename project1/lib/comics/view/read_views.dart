
import 'package:flutter/material.dart';
import 'package:project1/nav/widgets.dart';
import 'package:project1/comics/model/chapters.dart';


class ReadViews extends StatelessWidget {
  const ReadViews({Key? key, required this.chapters}) : super(key: key);

  final Chapters chapters;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: subAppBar("${chapters.name}"),
        body: Center(
          child: chapters.links != null && chapters.links!.isNotEmpty
              ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: (){},
                          child: btnName(true),
                          style: btnStyle(),
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child: btnName(false),
                        style: btnStyle(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: chapters.links!.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: (){},
                            child: Column(
                              children: [
                                ListTile(
                                  title: Image.network(chapters.links![index].toString())
                                ),
                                const Divider(thickness: 1,)
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              )
          ): const Center(
            child: Text("We are translating this comic", style: TextStyle(fontSize: 20),),
          ),
        ),
      ),
    );
  }
}
