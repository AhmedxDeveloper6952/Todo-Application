import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/authwrapper.dart';
import 'package:todoapp/favouritemodel.dart';
import 'package:todoapp/taskmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyC6mVaOuQI8YwzcC-EZ4X59rtlcln9qMwE",
        appId: "1:795458917553:android:b377b0176f41347c3e3e90",
        messagingSenderId: "795458917553",
        projectId: "toodoapp-d2bcc"),
  );
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskModel()),
      ChangeNotifierProvider(create: (_) => Favouritemodel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: AuthWrapper(),
    );
  }
}
