import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/screens/player_scan.dart';
import 'package:flutter_gemini/screens/text_from_text.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:d_chart/d_chart.dart';
import 'colours.dart';
import 'player_training.dart';

class PlayerlistPage extends StatefulWidget {
  final String title;
  const PlayerlistPage({super.key, required this.title});

  @override
  State<PlayerlistPage> createState() => _PlayerlistPageState();
}

List<int> indicatorList = [10, 50, 100];

class _PlayerlistPageState extends State<PlayerlistPage> {
  TextEditingController playerNameCont = TextEditingController();
  TextEditingController playerNumberont = TextEditingController();
  TextEditingController playerPositionCont = TextEditingController();

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: DChartPieO(
                //     data: ordinalDataList,
                //     customLabel: (ordinalData, index) {
                //       return '${ordinalData.measure}%';
                //     },
                //     configRenderPie: ConfigRenderPie(
                //       strokeWidthPx: 2,
                //       arcLabelDecorator: ArcLabelDecorator(),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 40, right: 40, bottom: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          padding: EdgeInsets.all(15)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            addPlayerContainer(
                                                playerNameCont,
                                                "اسم اللاعب الثنائي",
                                                "اسم اللاعب"),
                                            addPlayerContainer(playerNumberont,
                                                "رقم اللاعب", "رقم اللاعب"),
                                            addPlayerContainer(
                                                playerPositionCont,
                                                "حارس مرمى - دفاع - هجوم او وسط",
                                                "موقع اللاعب"),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("players")
                                                  .add({
                                                "name": playerNameCont.text,
                                                "number": playerNumberont.text,
                                                "position":
                                                    playerPositionCont.text,
                                              });
                                              playerNameCont.clear();
                                              playerNumberont.clear();
                                              playerPositionCont.clear();
                                            },
                                            child: Text("حفظ البيانات")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              playerNameCont.clear();
                                              playerNumberont.clear();
                                              playerPositionCont.clear();
                                            },
                                            child: Text("إلغاء"))
                                      ],
                                    );
                                  },
                                ),
                              );
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("اضافة لاعب جديد",
                              style: TextStyle(
                                  color: yellowColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.person_add,
                            color: yellowColor,
                            size: 24,
                          ),
                        ],
                      )),
                ),
                Text(
                    "يمكنك من اضافة لاعب جديد لتحليل اداءه ومعرفة مستوى تقدمه"),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 2,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("players")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //this code will show a circular progress indicator on Flutter app screen
                          return SizedBox(
                              height: 50,
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Lottie.asset(
                                    "assets/images/football_loading.json"),
                              ));
                        }

                        //get data snapshot (document) from your collection
                        final playerdata = snapshot.data?.docs;

                        if (playerdata!.isEmpty) {
                          //if there is no documents found in your collection
                          return const Text("لا توجد بيانات");
                        }
                        return ListView.separated(
                          itemCount: playerdata.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: yellowColor,
                              child: ListTile(
                                title: Text(
                                    "${playerdata[index]["name"]}- No.${playerdata[index]["number"]}",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                subtitle: Text(playerdata[index]["position"],
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                trailing: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => TextFromImage(
                                            playerName: playerdata[index]
                                                ["name"],
                                            playerID: playerdata[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.open_with)),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TextFromImage(
                                        playerName: playerdata[index]["name"],
                                        playerID: playerdata[index].id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              color: mainColor,
                              indent: 20,
                              endIndent: 20,
                            );
                          },
                        );
                      }),
                ),
                const SizedBox(height: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 40, right: 40, bottom: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                padding: EdgeInsets.all(15)),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const PlayerTraining(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('تدريبات اللاعبين',
                                    style: TextStyle(
                                        color: yellowColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.sports,
                                  color: yellowColor,
                                  size: 24,
                                ),
                              ],
                            )),
                      ),
                      Text(
                          "يوفر لك الذكاء الاصطناعي قائمة مختلفة بتدريبات اللاعبين")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: (){},
          child: Icon(Icons.sports_soccer, color: yellowColor,),
          ),
      ),
    );
  }

  Widget addPlayerContainer(
    TextEditingController pController,
    String pName,
    String pLabel,
  ) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: mainColor),
      child: TextFormField(
        controller: pController,
        style: TextStyle(color: yellowColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: pName,
          labelText: pLabel,
          hintStyle: TextStyle(color: Colors.white54),
          labelStyle: TextStyle(color: yellowColor),
          // fillColor: mainColor,
          // filled: true
        ),
      ),
    );
  }
}
