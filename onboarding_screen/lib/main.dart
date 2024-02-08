import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    home: const Boarding_Screen(),
   );
  }
}

class Boarding_Screen extends StatefulWidget {
  const Boarding_Screen({super.key});
  @override
  State<Boarding_Screen> createState() => _Boarding_ScreenState();
}

class _Boarding_ScreenState extends State<Boarding_Screen> {
  PageController obj= PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Column(
          children: [
            Expanded(
              child: PageView(controller: obj,
                  children: screens.map((e) =>
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children:[Text(e.description), SvgPicture.asset(e.img)]
                  )
                      ,margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20)
                  ),
                ),
                    ).toList()),
            ),
          SmoothPageIndicator(
          controller: obj,
          count: screens.length,
          effect: const WormEffect(
          dotHeight: 16,
          dotWidth: 16,
          type: WormType.thinUnderground,
          )),
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly, children: [TextButton(onPressed:(){}, child: Text('Skip')),
              ElevatedButton(onPressed:(){obj.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);}, child: Text('Next')) ],)
          ]
        )
    );
  }
}
