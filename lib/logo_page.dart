import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/colours.dart';
import 'package:flutter_gemini/screens/dashboard.dart';

import 'intro_slider_page.dart';
import 'screens/playerlist_page.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => IntroPager()
        // PlayerlistPage(title: '⚽️ PHOENIX GOAL ⚽️',)
        ));
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/soccer_pattern.jpeg',
                ),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
                opacity: .2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 250,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "مُسـاعدك الذكـي",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: mainColor,
        child: Text(
          "A PROJECT CREATED FOR AI LEAGUE Hackathon 2025 - SCAI 2025",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
