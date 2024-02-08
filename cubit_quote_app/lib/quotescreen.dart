import 'package:cubit_quote_app/cubit/homestates.dart';
import 'package:cubit_quote_app/model/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/homecubit.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  List<Quote> list = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QuoteCubit()..fetchData(),
        child: BlocConsumer<QuoteCubit,QuoteState>(
          listener: (context, state) {},
          builder: (context, state) {
            if(state is LoadingState) return Scaffold(body: Center(child: CircularProgressIndicator()),);
            QuoteCubit cubit= QuoteCubit.getInstance(context);
            return Scaffold(
              backgroundColor: Colors.lightBlue,
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(50),
                        child: const Text(
                          "Your Quote Today",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Container(margin:EdgeInsets.all(20) ,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red.withOpacity(0.2)),
                        child: Column(
                          children: [
                            Container(margin: const EdgeInsets.all(20),
                              child: Text(cubit.quoteObj?.author??"",
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(margin: const EdgeInsets.all(20),
                              child: Text(cubit.quoteObj?.content??""),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: (){cubit.fetchData();}, child: const Text('Reload')),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
