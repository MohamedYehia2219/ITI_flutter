import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final FirebaseAuth auth;
  Home({super.key,required this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).snapshots(),
      builder:(context, snapshot) => SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("WELCOME👋 ${snapshot.data?['name'] ?? ""}")],
              ),
            ),
          )
      ),
    );
  }
}





