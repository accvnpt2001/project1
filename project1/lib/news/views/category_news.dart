import 'package:flutter/material.dart';
import 'package:project1/nav/widgets.dart';
import 'package:project1/news/controller/news.dart';
import 'package:project1/news/models/article_model.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: subAppBar(widget.category.toUpperCase()),
        body: _loading ? const Center(
          child: CircularProgressIndicator(),
        ) :SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: articles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return BlogTitle(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                        publishedAt: articles[index].publishedAt,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// cac muc tin
class BlogTitle extends StatelessWidget {

  final String imageUrl, title, desc, url;
  final publishedAt;
  const BlogTitle({
    required this.imageUrl,
    required this.publishedAt,
    required this.title,
    required this.desc,
    required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleViews(
              blogUrl: url,
            ))
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.network(imageUrl),
              borderRadius: BorderRadius.circular(6),
            ),
            const SizedBox(height: 5),
            Text(publishedAt, style: const TextStyle(
                fontSize: 12,
                color: Colors.black38,
            ),),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),),
            const SizedBox(height: 5),
            Text(desc, style: const TextStyle(
                color: Colors.black54
            ),),
            const SizedBox(height: 10,),
            Divider(
              height: 5,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
