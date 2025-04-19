import 'package:clipboard/clipboard.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:flutter_gemini/screens/colours.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

//https://pixabay.com/sound-effects/search/football/
//https://www.freepik.com/

class TextFromImage extends StatefulWidget {
  const TextFromImage({super.key});

  static final _textController = TextEditingController();

  @override
  State<TextFromImage> createState() => _TextFromImageState();
}

String promptText = "";
String buttonsText = "";

class _TextFromImageState extends State<TextFromImage> {
  late VideoPlayerController _controller;

// late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();

    // Start the player as soon as the app is displayed.
    // player.setSource(AssetSource('palming.mp3'));

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await player.setSource(AssetSource('palming-football-34928.mp3'));
    //   await player.resume();
    // });

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // _initializeVideoPlayerFuture = _controller.initialize();
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    // _controller = VideoPlayerController.networkUrl(Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);
    final mediaProvider = Provider.of<MediaProvider>(context);

    return PopScope(
      onPopInvokedWithResult: (val, res) async {
        mediaProvider.reset();
        geminiProvider.reset();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('PHOENIX GOAL'),
                  Text(
                    'تحليل أداء اللاعبين باستخدام الذكاء الاصطناعي',
                    style: TextStyle(fontSize: 12, ),
                  ),
                ],
              ),
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
                                          "إضغط لرفع الفيديو بطريقة التحليل التي تناسبك",
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
                                              backgroundColor: mainColor,
                                              padding: EdgeInsets.all(15)),
                                          onPressed: () {
                                            mediaProvider.setImage();
                                            setState(() {
                                              promptText = """
                                            اريد تحليل اداء اللاعب في الفيديو المرفق وهل هو لاعب مبتدئ، ممتاز، ام محترف؟،
                                             لا تقم باستخدام الرمز ** في الرد،
                                                قم بإضافة ايموجي في ردك.
                                                إن تم اضافة فيديوهات لاتحتوي على لاعبين كرة قدم، انت ترفض تحليلها.
                                                ممتاز .. اريد النتائج ك نسب مئوية تكمل الرقم 100
                                                اريد لهذه النسب ان تكمل العدد 100 
                                                لا تكتب لي مجموع التقييم
                                                مع كتابة نقاط القوة ونقاط الضعف للاعب
                                                    """;
                                              buttonsText =
                                                  "تحليل أداء اللاعب بشكل عام";
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text(
                                              "تحليل أداء اللاعب بشكل عام",
                                              style: TextStyle(
                                                  color: yellowColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
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
                                                      حلل لي أداء اللاعب من حيث السرعة والإنطلاقة، لا تقم باستخدام الرمز * في الرد،
                                                      قم بإضافة ايموجي في ردك.
                                                      إن تم اضافة فيديوهات لاتحتوي على لاعبين كرة قدم، انت ترفض تحليلها.
                                                ممتاز .. اريد النتائج ك نسب مئوية تكمل الرقم 100
                                                اريد لهذه النسب ان تكمل العدد 100 
                                                لا تكتب لي مجموع التقييم
                                                      مع كتابة نقاط القوة ونقاط الضعف للاعب
                                                          """;
                                              buttonsText =
                                                  "اداء اللاعب من حيث السرعة والانطلاقة";
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text(
                                              "اداء اللاعب من حيث السرعة والانطلاقة",
                                              style: TextStyle(
                                                  color: yellowColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
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
                                                      حلل لي أداء اللاعب من حيث دقة التمرير، لا تقم باستخدام الرمز * في الرد،
                                                      قم بإضافة ايموجي في ردك.
                                                      إن تم اضافة فيديوهات لاتحتوي على لاعبين كرة قدم، انت ترفض تحليلها.
                                                ممتاز .. اريد النتائج ك نسب مئوية تكمل الرقم 100
                                                اريد لهذه النسب ان تكمل العدد 100 
                                                لا تكتب لي مجموع التقييم
                                                      مع كتابة نقاط القوة ونقاط الضعف للاعب
                                                          """;
                                              buttonsText =
                                                  "اداء اللاعب من حيث دقة التمرير";
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text(
                                              "اداء اللاعب من حيث دقة التمرير",
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
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
                                                      لا تقم باستخدام الرمز * في الرد،
                                                      قم بإضافة ايموجي في ردك.
                                                      إن تم اضافة فيديوهات لاتحتوي على لاعبين كرة قدم، انت ترفض تحليلها.
                                                ممتاز .. اريد النتائج ك نسب مئوية تكمل الرقم 100
                                                اريد لهذه النسب ان تكمل العدد 100 
                                                لا تكتب لي مجموع التقييم
                                                      مع كتابة نقاط القوة ونقاط الضعف للاعب
                                                          """;
                                              buttonsText =
                                                  "اداء اللاعب من حيث اتخاذ القرار";
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text(
                                              "اداء اللاعب من حيث اتخاذ القرار",
                                              style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ),
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
                                onPressed: () {
                                  geminiProvider.generateContentFromImage(
                                    // prompt: TextFromImage._textController.text,
                                    prompt: promptText,
                                    bytes: mediaProvider.bytes!,
                                  );
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
                                          child:
                                              geminiProvider.indicator_list ==
                                                      null || geminiProvider.ordinalDataList == null
                                                  ? SizedBox()
                                                  : ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: geminiProvider
                                                          .indicator_list!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return AspectRatio(
                                                          aspectRatio: 16 / 9,
                                                          child: DChartPieO(
                                                            data: geminiProvider.ordinalDataList!,
                                                            customLabel:
                                                                (ordinalData,
                                                                    index) {
                                                              return '${ordinalData.measure}%';
                                                            },
                                                            configRenderPie:
                                                                ConfigRenderPie(
                                                              strokeWidthPx: 2,
                                                              arcLabelDecorator:
                                                                  ArcLabelDecorator(),
                                                            ),
                                                          ),
                                                        );

                                                        // CircularPercentIndicator(
                                                        //     radius: 60.0,
                                                        //     lineWidth: 5.0,
                                                        //     percent: 1.0,
                                                        //     center: Text(
                                                        //         "${geminiProvider.indicator_list![index]}%"),
                                                        //     progressColor: int.parse(
                                                        //                 geminiProvider.indicator_list![
                                                        //                     index]) <=
                                                        //             30
                                                        //         ? Colors.red
                                                        //         : (int.parse(geminiProvider.indicator_list![
                                                        //                     index]) <=
                                                        //                 60
                                                        //             ? Colors
                                                        //                 .orange
                                                        //             : Colors
                                                        //                 .green));
                                                      },
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
                                                geminiProvider.response == null
                                            ? SizedBox()
                                            : Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      style:
                                                          IconButton.styleFrom(
                                                              backgroundColor:
                                                                  yellowColor,
                                                              foregroundColor:
                                                                  Colors.black,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15)),
                                                      onPressed: () {
                                                        FlutterClipboard.copy(
                                                                geminiProvider
                                                                    .response!)
                                                            .then((value) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "تم النسخ بنجاح")));
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
                                                      style:
                                                          IconButton.styleFrom(
                                                              backgroundColor:
                                                                  yellowColor,
                                                              foregroundColor:
                                                                  Colors.black,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15)),
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
                        // geminiProvider.ordinalDataList = null;
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
    );
  }
}
