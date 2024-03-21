import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_conference_app/firebase_options.dart';
import 'package:video_conference_app/utils/colors.dart';
import 'package:video_conference_app/view/home_page.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Conference App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const HomePage(),
    );
  }
}
