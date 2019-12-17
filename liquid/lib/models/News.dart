
class News {
  String newsId;
  String title;
  String content;
  dynamic datetime;


  News({
    this.newsId,
    this.title,
    this.content,
    this.datetime
  });

  Map<String, Object> toJson() {
    return {
      'newsId': newsId == null ? '' : newsId,
      'title': title == null ? '' : title,
      'content': content == null ? '' : content,
      'datetime': datetime == null ? 0 : datetime,
    };
  }

  factory News.fromJson(Map<dynamic, dynamic> doc) {
    News news = new News(
      newsId: doc['newsId'] == null ? '' : doc['newsId'],
      title: doc['title'] == null ? '' : doc['title'],
      content: doc['content'] == null ? '' : doc['content'],
      datetime: doc['datetime'] == null ? 0 : doc['datetime'],
    );
    return news;
  }

}