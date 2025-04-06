
import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/colours.dart';
import 'package:flutter_gemini/screens/dashboard.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(title: 'PHOENIX GOAL ⚽️',)));
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png", height: 150,),
          Text(
            "The Ultimate AI Driven Coach Assistant",
            style: TextStyle(fontSize: 16),
          ),
        ],
      )
    ),
    bottomNavigationBar: BottomAppBar(
      height: 50,
      color: mainColor,
      child: Text(
        "A PROJECT CREATED FOR AI LEAGUE 2025 - SAUDIA",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white
        ),),
    ),
    );
  }
}
