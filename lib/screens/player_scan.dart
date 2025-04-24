import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:flutter_gemini/screens/colours.dart';
import 'package:flutter_gemini/screens/player_history.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

//https://pixabay.com/sound-effects/search/football/
//https://www.freepik.com/

class TextFromImage extends StatefulWidget {
  final String playerName;
  final String playerID;
  const TextFromImage(
      {super.key, required this.playerName, required this.playerID});

  @override
  State<TextFromImage> createState() => _TextFromImageState();
}

String promptText = "";
String buttonsText = "";

class _TextFromImageState extends State<TextFromImage> {
  TextEditingController playerNameCont = TextEditingController();
  TextEditingController playerNumberont = TextEditingController();
  TextEditingController playerPositionCont = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);
    final mediaProvider = Provider.of<MediaProvider>(context);

    String systemPrompt = """
   انت تكتب اسم اللاعب ${widget.playerName} في بداية الرد
   وكذلك تكتب القيمة السوقية التقديرية للاعب بالريال السعودي،القيمة السوقية فقط تكتبها بالاحرف وليس بالارقام
   انت تكتب عنوان الفيديو المرفق لك ولا تكتب ارقام في العنوان
  لا تقم باستخدام الرمز ** في الرد،
  قم بإضافة ايموجي في ردك.
  إن تم اضافة فيديوهات لاتحتوي على لاعبين كرة قدم، انت ترفض تحليلها
  ممتاز .. اريد النتائج ك نسب مئوية تكمل الرقم 100
  اريد لهذه النسب ان تكمل العدد 100 لكن لا تكتب الرقم 100 في اجابتك
  مع كتابة نقاط القوة ونقاط الضعف للاعب
""";

    return PopScope(
      onPopInvokedWithResult: (val, res) async {
        mediaProvider.reset();
        geminiProvider.reset();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: PopScope(
          onPopInvokedWithResult: (bool1, index) {
            bool1 = true;
            geminiProvider.ordinalDataList.clear();
          },
          child: Scaffold(
              appBar: AppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('PHOENIX GOAL'),
                    Text(
                      'تحليل أداء اللاعب ${widget.playerName} باستخدام الذكاء الاصطناعي',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext) {
                              return AlertDialog(
                                title: Text("حذف اللاعب"),
                                content: Text(
                                    "سيتم حذف بيانات اللاعب ${widget.playerName} نهائياً"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("players")
                                            .doc(widget.playerID)
                                            .delete();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "حذف",
                                        style: TextStyle(color: redColor),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor),
                                      onPressed: () {},
                                      child: Text(
                                        "تراجع",
                                        style: TextStyle(color: yellowColor),
                                      ))
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: redColor,
                      )),

                  //edit data
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("تعديل بيانات اللاعب"),
                                          Text(
                                            "سيتم الخروج من الواجهة الحالية لأتمام عملية التعديل",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            addPlayerContainer(
                                                playerNameCont,
                                                "اسم اللاعب الثنائي",
                                                "اسم اللاعب", "name"),
                                            addPlayerContainer(playerNumberont,
                                                "رقم اللاعب", "رقم اللاعب", "number"),
                                            addPlayerContainer(
                                                playerPositionCont,
                                                "حارس مرمى - دفاع - هجوم او وسط",
                                                "موقع اللاعب", "position"),
                                          ],
                                        ),
                                      ),
                                      actions: [
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
                      icon: Icon(
                        Icons.edit,
                        color: orangeColor,
                      ))
                ],
                foregroundColor: Colors.black,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Stack(
                children: [
                  Positioned(
                      bottom: 1,
                      child: Image.asset("assets/images/football.png",
                          width: MediaQuery.sizeOf(context).width)),
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Container(
                      margin: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView(
                            children: [
                              mediaProvider.bytes == null
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                        ),
                                        Text(
                                            "اختر من القائمة ادناه لرفع وتحليل الفيديو",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  1.3,
                                          child: IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: greenColor,
                                                padding: EdgeInsets.all(15)),
                                            onPressed: () {
                                              mediaProvider.setImage();
                                              setState(() {
                                                promptText = """
                                              اريد تحليل اداء اللاعب في الفيديو المرفق وهل هو لاعب مبتدئ، ممتاز، ام محترف؟،
                                             $systemPrompt
                                                      """;
                                                buttonsText =
                                                    "أداء اللاعب بشكل عام";
                                              });
                                            },
                                            icon: Text("أداء اللاعب بشكل عام",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  1.3,
                                          child: IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: purpleColor,
                                                padding: EdgeInsets.all(15)),
                                            onPressed: () {
                                              mediaProvider.setImage();
                                              setState(() {
                                                promptText = """
                                                        حلل لي أداء اللاعب من حيث السرعة والإنطلاقة، $systemPrompt
                                                            """;
                                                buttonsText =
                                                    "اداء اللاعب من حيث السرعة والانطلاقة";
                                              });
                                            },
                                            icon: Text(
                                                "اداء اللاعب من حيث السرعة والانطلاقة",
                                                style: TextStyle(
                                                    color: yellowColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  1.3,
                                          child: IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: greenColor,
                                                padding: EdgeInsets.all(15)),
                                            onPressed: () {
                                              mediaProvider.setImage();
                                              setState(() {
                                                promptText = """
                                                        حلل لي أداء اللاعب من حيث دقة التمرير، $systemPrompt
                                                            """;
                                                buttonsText =
                                                    "اداء اللاعب من حيث دقة التمرير";
                                              });
                                            },
                                            icon: Text(
                                                "اداء اللاعب من حيث دقة التمرير",
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  1.3,
                                          child: IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: orangeColor,
                                                padding: EdgeInsets.all(15)),
                                            onPressed: () {
                                              mediaProvider.setImage();
                                              setState(() {
                                                promptText = """
                                                        حلل لي أداء اللاعب من حيث اتخاذ القرار، هل يمرر، يسدد أو يراوغ بشكل صحيح؟
                                                        $systemPrompt
                                                            """;
                                                buttonsText =
                                                    "اداء اللاعب من حيث اتخاذ القرار";
                                              });
                                            },
                                            icon: Text(
                                                "اداء اللاعب من حيث اتخاذ القرار",
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 70,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: mainColor,
                                              padding: EdgeInsets.all(30)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlayerHistory(
                                                            playerName: widget
                                                                .playerName,
                                                            playerID: widget
                                                                .playerID)));
                                          },
                                          child: Text(
                                              "اضعط لعرض التحليلات السابقة للاعب ${widget.playerName}",
                                              style: TextStyle(
                                                  color: yellowColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                        "✅ تم إضافة الفيديو بنجاح",
                                        style: TextStyle(
                                            color: yellowColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                              const SizedBox(height: 16),
                              Center(
                                  child: Text(
                                mediaProvider.bytes == null
                                    ? ""
                                    : "سنقوم بتحليل $buttonsText",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )),
                              const SizedBox(height: 16),
                              if (mediaProvider.bytes != null)
                                ElevatedButton(
                                  onPressed: () async {
                                    await geminiProvider
                                        .generateContentFromImage(
                                      // prompt: TextFromImage._textController.text,
                                      prompt: promptText,
                                      bytes: mediaProvider.bytes!,
                                    );
                                    FirebaseFirestore.instance
                                        .collection("players")
                                        .doc(widget.playerID)
                                        .collection("player_data")
                                        .add({
                                      "analyis_type": buttonsText,
                                      "analyis_data": geminiProvider.response,
                                      "timestamp": DateTime.now()
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.all(15)),
                                  child: Text('تحليل',
                                      style: TextStyle(
                                          color: yellowColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              const SizedBox(height: 16),
                              geminiProvider.isLoading
                                  ? SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Lottie.asset(
                                          "assets/images/football_loading.json"),
                                    )
                                  : Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            height: 250,
                                            child: geminiProvider
                                                            .indicator_list ==
                                                        null ||
                                                    geminiProvider
                                                        .ordinalDataList.isEmpty
                                                ? SizedBox()
                                                : AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: DChartPieO(
                                                      data: geminiProvider
                                                          .ordinalDataList,
                                                      customLabel:
                                                          (ordinalData, index) {
                                                        return '${ordinalData.measure}%';
                                                      },
                                                      configRenderPie:
                                                          ConfigRenderPie(
                                                        strokeWidthPx: 2,
                                                        arcLabelDecorator:
                                                            ArcLabelDecorator(),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            geminiProvider.response ?? '',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          mediaProvider.bytes == null ||
                                                  geminiProvider.response ==
                                                      null
                                              ? SizedBox()
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        style: IconButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    yellowColor,
                                                                foregroundColor:
                                                                    Colors
                                                                        .black,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15)),
                                                        onPressed: () {
                                                          FlutterClipboard.copy(
                                                                  geminiProvider
                                                                      .response!)
                                                              .then((value) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text("تم النسخ بنجاح")));
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.copy,
                                                          color: mainColor,
                                                        )),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    IconButton(
                                                        style: IconButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    yellowColor,
                                                                foregroundColor:
                                                                    Colors
                                                                        .black,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15)),
                                                        onPressed: () {
                                                          geminiProvider
                                                              .generateContentFromImage(
                                                            // prompt: TextFromImage._textController.text,
                                                            prompt: promptText,
                                                            bytes: mediaProvider
                                                                .bytes!,
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.refresh,
                                                          color: mainColor,
                                                        ))
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: mediaProvider.bytes != null
                  ? FloatingActionButton(
                      backgroundColor: mainColor,
                      onPressed: () {
                        setState(() {
                          mediaProvider.bytes = null;
                          geminiProvider.response = null;
                          promptText = "";
                          geminiProvider.isLoading = false;
                          geminiProvider.ordinalDataList.clear();
                        });
                      },
                      tooltip: "العودة للصفحة السابقة",
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: yellowColor,
                      ),
                    )
                  : Container()),
        ),
      ),
    );
  }

  Widget addPlayerContainer(
    TextEditingController pController,
    String pName,
    String pLabel,
    String fieldTitle
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
            suffixIcon: IconButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("players")
                      .doc(widget.playerID)
                      .update({
                    fieldTitle: playerNameCont.text,
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.edit,
                  color: orangeColor,
                ))),
      ),
    );
  }
}
