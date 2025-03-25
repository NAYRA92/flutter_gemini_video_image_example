import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/landing_page.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:flutter_gemini/screens/dashboard.dart';
import 'package:provider/provider.dart';

import 'screens/colours.dart';

void main() {
  // await dotenv.load(fileName: '.env');
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
        title: 'PHONIX GOAL ⚽️',
        home: LogoPage(),
      ),
    );
  }
}
