import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/button.dart';
import 'package:todoapp/signup.dart';
import 'package:todoapp/textfield.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Get the user's UID
      String uid = userCredential.user!.uid;

      // Fetch user data
      fetchuserdata(uid);
    } on FirebaseAuthException catch (e) {
      // Handle error
      print(e.message);
    }
  }

  Future<void> fetchuserdata(String uid) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      // Use userData
      print("User Data: $userData");
    } else {
      print("User does not exist in Firestore");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.login,
            size: 60,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Enter your Login details",
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
            text: "Login",
            onPressed: login,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
