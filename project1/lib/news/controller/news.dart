
import 'dart:convert';
import 'package:project1/news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  // Tin chung load tai home
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=89371ff0fb954e5fa65785e10e501404";

    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);

    if(jsonData["status"] == "ok"){
        jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null  && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            publishedAt: element["publishedAt"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass{
  // tin rieng cua tung title
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=89371ff0fb954e5fa65785e10e501404";

    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);

    if(jsonData["status"] == "ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null  && element["description"] != null){
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              publishedAt: element["publishedAt"]
          );
          news.add(articleModel); // duyet tung ptu va add vao news[]
        }
      });
    }
  }
}