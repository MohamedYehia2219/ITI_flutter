class Quote
{
  String? content;
  String? author;

  Quote(this.content,this.author);

  Quote.fromMap(Map<String, dynamic> jsonMap) {
    content = jsonMap['content'];
    author = jsonMap['author'];
  }
}