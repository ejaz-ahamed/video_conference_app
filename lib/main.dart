import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_conference_app/firebase_options.dart';
import 'package:video_conference_app/view/index.dart';
import 'package:video_conference_app/view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Conference App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: user == null ? const LoginPage() : const HomePage(),
    );
  }
}
