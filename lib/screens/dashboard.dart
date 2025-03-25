import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/text_from_image.dart';
import 'package:flutter_gemini/screens/text_from_text.dart';

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
            children: [
              const Text(
                "قم بإختيار أحد الأنواع التالية",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => const TextFromTextScreen(),
              //       ),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     side: const BorderSide(
              //       color: Colors.black,
              //       width: 1,
              //     ),
              //     backgroundColor: Colors.white,
              //     foregroundColor: Colors.black,
              //   ),
              //   child: const Text('Text from Text'),
              // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
