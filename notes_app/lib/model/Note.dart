import 'package:notes_app/db/constants.dart';

class Note {
  int? id;
  String title = '';
  String text = '';
  String date = '';
  int color = 0;
  String? lastUpdate;


  Note({this.id, required this.title, required this.text, required this.date, required this.color, this.lastUpdate});

  Map<String, dynamic> toMap() =>
      {colId: id, colTitle: title, colText: text, colDate: date, colColor: color, colLastUdpate:lastUpdate };

  Note.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    title = map[colTitle];
    text = map[colText];
    date = map[colDate];
    color=map[colColor];
    lastUpdate=map[colLastUdpate];
  }
}
