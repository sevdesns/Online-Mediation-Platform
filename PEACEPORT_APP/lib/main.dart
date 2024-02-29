import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyATKtiFC4a2I3wAcjyBK6MJOC8h6vs4BGI", 
            appId: "1:58963407730:android:6404ffc400c62c1f7a23eb", 
            messagingSenderId: "58963407730",                   
            projectId: "peace-8cae8",
          ),
        )
      : await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: Register(), // Veya istediğiniz başka bir sayfayı buraya ekleyebilirsiniz.
    );
  }
}
