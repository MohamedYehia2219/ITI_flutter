import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_lab/signup.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    auth=FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: Column( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0, color: Colors.white)),
                const SizedBox(height: 15,),
                Container(decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.all(5),margin: const EdgeInsets.all(10),
                  child: TextField(controller: _emailController,decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
                  ),
                ),
                Container(decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.all(5),margin: const EdgeInsets.all(10),
                  child: TextField(controller: _passwordController ,decoration: InputDecoration(border: InputBorder.none, hintText: "Password")
                  ),
                ),const SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  ElevatedButton(onPressed:signin, child: const Text('Login')),
                   TextButton(onPressed: goToSignup, child: const Text('Signup', style: TextStyle(color: Colors.white),) )
                ],)
              ],
            ),
          ),
      )
    );
  }

  signin()async{
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );
      if (credential.user != null) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Home(auth: auth)
        ));
      }
    } on FirebaseAuthException catch (e) {
      print('code: ${e.code}\n message:${e.message}');
    }
  }

  goToSignup()
  {
    Navigator.push(context,  MaterialPageRoute(
          builder: (context) => Signup(),
        ));
  }
}
