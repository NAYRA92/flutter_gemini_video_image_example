import 'package:audioplayers/audioplayers.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:flutter_gemini/screens/colours.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

//https://pixabay.com/sound-effects/search/football/
//https://www.freepik.com/

class PlayerTraining extends StatefulWidget {
  const PlayerTraining({super.key});

  static final _textController = TextEditingController();

  @override
  State<PlayerTraining> createState() => _PlayerTrainingState();
}

String promptText = "";
String buttonsText = "";

class _PlayerTrainingState extends State<PlayerTraining> {
  late VideoPlayerController _controller;
  late AudioPlayer player = AudioPlayer();
// late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    // Create the audio player.
    player = AudioPlayer();
    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);
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
    player.dispose();
    super.dispose();
  }

  bool isPressed = false;

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
                    'تدريبات مخصصة للاعبين باستخدام الذكاء الاصطناعي',
                    style: TextStyle(fontSize: 12),
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
                            isPressed == false
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 60,
                                      ),
                                      Text("إضغط لعرض التدريبات التي تناسبك",
                                          style: TextStyle(
                                              color: mainColor,
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
                                            setState(() {
                                              promptText = """
                                            اريد خمسة تدريبات لتحسين أداء حارس المرمى لكرة القدم، التي يحتاجها
                                             لا تقم باستخدام الرمز * في الرد،
                                                قم بإضافة ايموجي في ردك.
                                                    """;
                                              buttonsText =
                                                  "تدريبات حارس المرمى";
                                              isPressed = true;
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text("تدريبات حارس المرمى",
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
                                            setState(() {
                                              promptText = """
                                                       اريد خمسة تدريبات للاعبي الهجوم في كرة القدم، لا تقم باستخدام الرمز * في الرد،
                                                      قم بإضافة ايموجي في ردك.
                                                          """;
                                              buttonsText =
                                                  "تدريبات لاعبي الدفاع";
                                              isPressed = true;
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text("تدريبات لاعبي الدفاع",
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
                                            setState(() {
                                              promptText = """
                                                      اريد خمسة تدريبات للاعبي الظهير او الوسط، لا تقم باستخدام الرمز * في الرد،
                                                      قم بإضافة ايموجي في ردك.
                                                          """;
                                              buttonsText =
                                                  "تدريبات لاعبي الظهير/الوسط";
                                              isPressed = true;
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text(
                                              "تدريبات لاعبي الظهير/الوسط",
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
                                            setState(() {
                                              promptText = """
                                                      اريد خمسة تدريبات للاعبي الهجوم،
                                                      لا تقم باستخدام الرمز * في الرد،
                                                      قم بإضافة ايموجي في ردك.
                                                          """;
                                              buttonsText =
                                                  "تدريبات لاعبي الهجوم";
                                              isPressed = true;
                                            });
                                            // _controller =
                                            // VideoPlayerController.file(mediaProvider.bytes);
                                          },
                                          icon: Text("تدريبات لاعبي الهجوم",
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
                                      "",
                                      style: TextStyle(
                                          color: yellowColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                            const SizedBox(height: 16),
                            Center(
                                child: Text(
                              !isPressed ? "" : "تفضل خمسة من $buttonsText",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                            const SizedBox(height: 16),
                            if (isPressed)
                              ElevatedButton(
                                onPressed: () {
                                  geminiProvider.generateContentFromText(
                                    // prompt: TextFromImage._textController.text,
                                    prompt: promptText,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColor,
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.all(15)),
                                child: Text('إنشاء',
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
                                                            .then((value){
                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم النسخ بنجاح")));
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
                                                            .generateContentFromText(
                                                          // prompt: TextFromImage._textController.text,
                                                          prompt: promptText,
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
            floatingActionButton: isPressed
                ? FloatingActionButton(
                    backgroundColor: mainColor,
                    onPressed: () {
                      setState(() {
                        isPressed = false;
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
