import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MianPage extends StatefulWidget {
  @override
  State<MianPage> createState() => _MianPageState();
}

class _MianPageState extends State<MianPage> {
  String text='';
  bool flutter=false, android=false, frontend=false, backend=false;

  @override
  Widget build(BuildContext context) {
    text='Selected Courses are: ';
    if(flutter) text+='Flutter ';
    if(android) text+='Android ';
    if(frontend) text+='Frontend ';
    if(backend) text+='Backend ';

    return Scaffold(
      body: Center(
        child: Text('$text', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      bottomSheet:Builder(builder: (context) => Padding(padding: EdgeInsets.all(20),
      child: Wrap(
        children: [
          CheckboxListTile(title:Text('Flutter') , value:flutter , onChanged: (value){setState(() {
          flutter=value!;});} ),
          CheckboxListTile(title:Text('Android') , value:android , onChanged: (value){setState(() {
          android=value!;});} ),
          CheckboxListTile(title:Text('Front end') , value:frontend , onChanged: (value){setState(() {
          frontend=value!;});} ),
          CheckboxListTile(title:Text('Back end') , value:backend , onChanged: (value){setState(() {
          backend=value!;});} )
    ],),) ,
    ));
  }
}