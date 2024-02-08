import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quotes_app/data/datasource/remote/ApiService.dart';
import 'package:quotes_app/model/quote.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'data/datasource/remote/constants.dart';
import 'favourites.dart';

class QuoteScreen extends StatefulWidget {
  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  PageController pageController = PageController();
  QuoteResponse? obj;
  List<Quote> list = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(margin: EdgeInsets.all(50),child: Text("Your Quote Today", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize:30, fontStyle:FontStyle.italic ),)),
              Expanded(
                child: PageView(controller: pageController,
                    children: list.map((e) =>
                        Container(margin: EdgeInsets.fromLTRB(20,50,20,50), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text(e.author!, style:TextStyle(fontWeight: FontWeight.bold)) , Container(margin: EdgeInsets.all(20), child: Text(e.content!)),
                                                Container(margin: EdgeInsets.fromLTRB(300, 0, 0, 0) ,child: IconButton(onPressed:(){fav_quote(e);} , icon: Icon(Icons.favorite))),]),
                              )),
                        ).toList()),
              ),
              Container( margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.bounceIn);},
                        child: Text('Previous')),
                    ElevatedButton(onPressed: () {pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.bounceIn);},
                        child: Text('Next')),
                    ElevatedButton(onPressed: (){dispaly_fav();},child: Text('Favourites'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void fetchData() async {
    final result = await ApiService.api.fetchQuotes();
    setState(() {
      list = result.QuotesList ?? [];
    });
  }

  void fav_quote(Quote q)
  {
    QuoteBox.add(q);
    const snakbar= SnackBar(content: Text("Quote added successfully to favourites"));
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }

  void dispaly_fav()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Favourites()));
  }
}
