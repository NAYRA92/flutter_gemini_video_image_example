import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/player_scan.dart';
import 'package:flutter_gemini/screens/text_from_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:d_chart/d_chart.dart';
import 'player_training.dart';

class DashboardScreen extends StatefulWidget {
  final String title;
  const DashboardScreen({super.key, required this.title});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

List<int> indicatorList = [10, 50, 100];

class _DashboardScreenState extends State<DashboardScreen> {
  List<OrdinalData> ordinalDataList = [
    OrdinalData(
      domain: 'A',
      measure: indicatorList[0],
      color: indicatorList[0] <= 25
          ? Colors.red[200]
          : indicatorList[0] <= 50
              ? Colors.orangeAccent[200]
              : indicatorList[0] <= 80
              ? Colors.blue[200]
              : Colors.green[200],
    ),
    OrdinalData(
      domain: 'B',
      measure: indicatorList[1],
      color: indicatorList[1] <= 25
          ? Colors.red[200]
          : indicatorList[1] <= 50
              ? Colors.orangeAccent[200]
              : indicatorList[1] <= 80
              ? Colors.blue[200]
              : Colors.green[200],
    ),
    OrdinalData(
      domain: 'C',
      measure: indicatorList[2],
      color: indicatorList[2] <= 25
          ? Colors.red[200]
          : indicatorList[2] <= 50
              ? Colors.orangeAccent[200]
              : indicatorList[2] <= 80
              ? Colors.blue[200]
              : Colors.green[200],
    ),
  ];
  
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
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartPieO(
                  data: ordinalDataList,
                  customLabel: (ordinalData, index) {
                    return '${ordinalData.measure}%';
                  },
                  configRenderPie: ConfigRenderPie(
                    strokeWidthPx: 2,
                    arcLabelDecorator: ArcLabelDecorator(),
                  ),
                ),
              ),
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
