import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/logo_page.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:flutter_gemini/screens/dashboard.dart';
import 'package:flutter_gemini/studium_page.dart';
import 'package:provider/provider.dart';

import 'screens/colours.dart';
import 'screens/player_history.dart';
import 'screens/player_scan.dart';
import 'screens/playerlist_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( //unerror will appear here, but it will go as soon as you import the needed Firebase packages
      options: FirebaseOptions(
          apiKey: "AIzaSyC30CkY6t87r9U8m0x5-2sXFQah7XCVvq4", //you will find apiKey, appId ... etc indside the google-services.json file that you download from firebase console!
          appId: "343147209763",
          messagingSenderId: "sendid",
          projectId: "mytestproject-202406",
          storageBucket: "mytestproject-202406.appspot.com")); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GeminiProvider()),
        ChangeNotifierProvider(create: (context) => MediaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Cairo",
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
        title: '⚽️ PHOENIX GOAL ⚽️',
        home: LogoPage(),
      ),
    );
  }
}
