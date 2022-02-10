
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/nav/nav_comic.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // khoi tao firebase
  FirebaseApp app = await Firebase.initializeApp();
  if(Firebase.apps.isEmpty){
    app = await Firebase.initializeApp(
        name: 'Nana2',
        options: Platform.isMacOS || Platform.isIOS ?
        const FirebaseOptions(
            apiKey: 'AIzaSyAMpYEiMLRHfyrbFuf4eyalY2g9W-pUuSQ',
            appId: 'IOS KEY',
            messagingSenderId: '499268074370',
            projectId: 'nana-12be9',
            databaseURL: 'https://nana-12be9-default-rtdb.asia-southeast1.firebasedatabase.app'
        ):
        const FirebaseOptions(
            apiKey: 'AIzaSyAMpYEiMLRHfyrbFuf4eyalY2g9W-pUuSQ',
            appId: '1:499268074370:android:2f064e289fe172bb796d9b',
            messagingSenderId: '499268074370',
            projectId: 'nana-12be9',
            databaseURL: 'https://nana-12be9-default-rtdb.asia-southeast1.firebasedatabase.app'
        )
    );
  }
  else{
    Firebase.app();
  }
  runApp(ProviderScope(child: MyApp(app: app),));
}

class MyApp extends StatelessWidget {

  FirebaseApp app;
  MyApp({required this.app});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: NavComic()
    );
  }
}
