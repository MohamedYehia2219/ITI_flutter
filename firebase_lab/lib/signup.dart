import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignState();
}

class _SignState extends State<Signup> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    auth=FirebaseAuth.instance;
    firestore=FirebaseFirestore.instance;
  }

  @override
  void dispose()
  {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: SingleChildScrollView(
              child: Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("SIGN UP ",style: TextStyle(fontWeight: FontWeight.bold, fontSize:24, color: Colors.white)),
                  const SizedBox(height: 15,),
                  Container(decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.all(5),margin: const EdgeInsets.all(10),
                    child: TextField(controller: _emailController ,decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
                    ),
                  ),
                  Container(decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.all(5),margin: const EdgeInsets.all(10),
                    child: TextField(controller: _passwordController, decoration: InputDecoration(border: InputBorder.none, hintText: "Password")
                    ),
                  ),
                  Container(decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.all(5),margin: const EdgeInsets.all(10),
                    child: TextField(controller:_nameController, decoration: InputDecoration(border: InputBorder.none, hintText: "Name")
                    ),
                  ),
                  Container(decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.all(5),margin: const EdgeInsets.all(10),
                    child: TextField( controller:_phoneController ,decoration: InputDecoration(border: InputBorder.none, hintText: "Phone")
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(onPressed: signup, child: const Text('Signup')),
                ],
              ),
            ),
          ),
        )
    );
  }

  signup() async{
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );
      if (credential.user != null) {
        addToFireStore();
        print(credential);
        print(auth.currentUser!.uid);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(auth: auth)));
      }
    } on FirebaseAuthException catch (e) {
      print('code: ${e.code}\n message:${e.message}');
    }
  }

  addToFireStore(){
    firestore.collection("users").doc(auth.currentUser!.uid).set(
      {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'password':_passwordController.text.trim(),
        'phone': _phoneController.text.trim()
      }
    );
  }
}

