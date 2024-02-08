import 'package:hive/hive.dart';
part 'quote.g.dart';


class QuoteResponse {
  List<Quote>? QuotesList;

  //decode convert string to map, then we convert map to obj to use it
  QuoteResponse.fromMap(Map<String, dynamic> jsonMap){
     QuotesList = <Quote>[];
      jsonMap['results'].forEach((q) {
        QuotesList!.add(Quote.fromMap(q));
      });
  }
}

//flutter pub run build_runner build
@HiveType(typeId: 0)
class Quote {
  @HiveField(0)
  String? author;
  @HiveField(1)
  String? content;

  Quote({this.author, this.content,});

  Quote.fromMap(Map<String, dynamic> quoteMap) {
    author = quoteMap['author'];
    content = quoteMap['content'];
  }

  Map<String, dynamic> toMap() {
    return {"author": author, "content":content} ;
  }
}
