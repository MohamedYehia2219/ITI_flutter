import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'data/datasource/remote/constants.dart';
import 'model/quote.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SafeArea(
        child: Scaffold( backgroundColor: Colors.lightBlue,
          body: Column(
              children: [
                ValueListenableBuilder<Box<Quote>>(
                    valueListenable: QuoteBox.listenable(),
                    builder: (context, QuoteBox, child) => ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(color:Colors.purpleAccent,),
                          child: ListTile(
                            leading: Icon(Icons.note),
                            title: Text(QuoteBox.getAt(index)!.author!),
                            subtitle: Text(QuoteBox.getAt(index)!.content!),
                            trailing: Icon(Icons.favorite),
                          ),
                        ),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: QuoteBox.length))
              ]),
        ),
      ) ,
    );
  }
}
