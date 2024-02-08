import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(RollDice());
}

class RollDice  extends StatefulWidget {
  @override
  State<RollDice> createState() => _RollDiceState();
}

class _RollDiceState extends State<RollDice> {
  int img1=1,img2=6, imgSelector=0;
  bool oneDice=false;
  void randomImg()
  {
    setState(() {
      if(!oneDice)
      {
        img1 = Random().nextInt(6) + 1;
        img2 = Random().nextInt(6) + 1;
      }
      else
      {
        imgSelector=Random().nextInt(2) + 1;
        if(imgSelector==1)
          {
            img1 = Random().nextInt(6) + 1;
          }
        else if(imgSelector==2)
        {
          img2 = Random().nextInt(6) + 1;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(title: const Text('The Dice App', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          backgroundColor: Colors.lightBlue,
          actions: [TextButton(onPressed: (){oneDice=true;}, child: const Text('Roll One Dice', style: TextStyle(color: Colors.black)))],
        ),
        body: Center(
          child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [const Text('Shake to throw', style: TextStyle(fontWeight: FontWeight.bold),),
              Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:[Image.asset('images/dice$img1.png',width: 150, height: 150),
                Image.asset('images/dice$img2.png', width: 150, height: 150)]),
            ElevatedButton(onPressed: randomImg, child: const Text('Roll Dice'))],
          ),
        ),
      )
    );
  }
}

