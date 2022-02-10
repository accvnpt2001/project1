// class cac muc tin
class ArticleModel{
  dynamic author;
  dynamic title;
  dynamic description;
  dynamic url;
  dynamic urlToImage;
  dynamic content;
  dynamic publishedAt;

  ArticleModel({
    this.publishedAt,
    this.url,
    this.title,
    this.author,
    this.content,
    this.urlToImage,
    this.description});
}