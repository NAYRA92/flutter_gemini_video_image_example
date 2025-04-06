import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/player_scan.dart';
import 'package:flutter_gemini/screens/text_from_text.dart';

import 'player_training.dart';

class DashboardScreen extends StatefulWidget {
  final String title;
  const DashboardScreen({super.key, required this.title});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "قم بإختيار أحد الأنواع التالية",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TextFromImage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text('تحليل أداء اللاعب'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PlayerTraining(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text('تدريبات اللاعبين'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
