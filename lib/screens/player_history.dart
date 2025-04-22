import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/colours.dart';
import 'package:lottie/lottie.dart';

class PlayerHistory extends StatefulWidget {
  final String playerName;
  final String playerID;
  const PlayerHistory(
      {super.key, required this.playerName, required this.playerID});

  @override
  State<PlayerHistory> createState() => _PlayerHistoryState();
}

List<String> extractNumbers(String text) {
  RegExp regExp =
      RegExp(r'\b\d+\b'); // Matches one or more digits as a whole word
  Iterable<Match> matches = regExp.allMatches(text);
  return matches.map((match) => match.group(0)!).toList();
}

// List<String>? indicator_list;
List<OrdinalData> ordinalDataList = [];
List<String> indicatorList = [];

class _PlayerHistoryState extends State<PlayerHistory> {
  List<OrdinalData> createPieGraph(String response) {
    indicatorList = extractNumbers(response);
    print("Extracted Numbers: $indicatorList");
    try{
      for (int i = 0; i < indicatorList.length; i++) {
      ordinalDataList.add(
        OrdinalData(
          domain: 'Item $i',
          measure: int.parse(indicatorList[i]),
          color: int.parse(indicatorList[i]) <= 25
              ? Colors.red[200]
              : int.parse(indicatorList[i]) <= 50
                  ? Colors.orangeAccent[200]
                  : int.parse(indicatorList[i]) <= 80
                      ? Colors.blue[200]
                      : Colors.green[200],
        ),
      );
    }
    return ordinalDataList;
    }
    catch(e){
    print("Error Message: $e");
    return ordinalDataList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("بيانات اللاعب ${widget.playerName} السابقة"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("players")
                  .doc(widget.playerID)
                  .collection("player_data").orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                        height: 150,
                        child: Lottie.asset(
                            "assets/images/football_loading.json")),
                  );
                } if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("لا توجد بيانات سابقة بعد"));
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ordinalDataList.clear();
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: orangeLightColor,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    color: purpleColor),
                                child: Center(
                                  child: Text(
                                    snapshot.data!.docs[index]["analyis_type"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: DChartPieO(
                                  data: createPieGraph(snapshot
                                      .data!.docs[index]["analyis_data"]),
                                  customLabel: (ordinalData, index) {
                                    return '${ordinalData.measure}%';
                                  },
                                  configRenderPie: ConfigRenderPie(
                                    strokeWidthPx: 2,
                                    arcLabelDecorator: ArcLabelDecorator(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!.docs[index]["analyis_data"],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
