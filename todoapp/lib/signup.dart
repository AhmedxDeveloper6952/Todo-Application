import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/button.dart';
import 'package:todoapp/textfield.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signup() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Get the user's UID
      String uid = userCredential.user!.uid;
      adduserdata(
        uid,
        emailController.text,
      );
      // Optionally, save additional user information to Firestore
    } on FirebaseAuthException catch (e) {
      // Handle error
      print(e.message);
    }
  }

  Future adduserdata(
    String uid,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "email": email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sign_language,
            size: 60,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Enter your Signup details",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 30,
          ),
          Textfield(
            obscureText: false,
            prefixIcon: const Icon(Icons.email_outlined),
            hintText: "Email Address",
            onTap: () {},
            controller: emailController,
          ),
          const SizedBox(
            height: 23,
          ),
          Textfield(
            obscureText: true,
            prefixIcon: const Icon(Icons.password_outlined),
            onTap: () {},
            hintText: "Password",
            controller: passwordController,
          ),
          const SizedBox(
            height: 15,
          ),
          Mubutton(
            color: Colors.teal,
            text: "Signup",
            onPressed: signup,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account ? "),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
