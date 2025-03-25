import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TextFromImage extends StatefulWidget {
  const TextFromImage({super.key});

  static final _textController = TextEditingController();

  @override
  State<TextFromImage> createState() => _TextFromImageState();
}


class _TextFromImageState extends State<TextFromImage> {
  
late VideoPlayerController _controller;
// late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
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
            title: const Text('تحليل الأداء ✨'),
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    mediaProvider.bytes == null
                        ? IconButton(
                            onPressed: () {
                              mediaProvider.setImage();
                              // _controller =
                              // VideoPlayerController.file(mediaProvider.bytes);
                            },
                            icon: const Icon(Icons.add),
                          )
                        : Text(
                            "تم إضافة الفيديو بنجاح",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                    //     AspectRatio(
                    //   aspectRatio: _controller.value.aspectRatio,
                    //   child: VideoPlayer(_controller),
                    // ),
                    // FutureBuilder(
                    //   future: _initializeVideoPlayerFuture,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       // If the VideoPlayerController has finished initialization, use
                    //       // the data it provides to limit the aspect ratio of the video.
                    //       return AspectRatio(
                    //         aspectRatio: _controller.value.aspectRatio,
                    //         // Use the VideoPlayer widget to display the video.
                    //         child: VideoPlayer(_controller),
                    //       );
                    //     } else {
                    //       // If the VideoPlayerController is still initializing, show a
                    //       // loading spinner.
                    //       return const Center(
                    //           child: CircularProgressIndicator());
                    //     }
                    //   },
                    // ),
                    const SizedBox(height: 16),
                    // TextField(
                    //   controller: TextFromImage._textController,
                    //   decoration: const InputDecoration(
                    //     hintText: '...',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    if (mediaProvider.bytes != null)
                      ElevatedButton(
                        onPressed: () {
                          geminiProvider.generateContentFromImage(
                            prompt:
                                "اريد تحليل اداء اللاعب في الفيديو المرفق وهل هو لاعب مبتدئ، ممتاز، ام محترف؟، لا تقم باستخدام الرمز * في ردك",
                            // prompt: TextFromImage._textController.text,
                            bytes: mediaProvider.bytes!,
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
                        child: const Text('تحليل'),
                      ),
                    const SizedBox(height: 16),
                    geminiProvider.isLoading
                        ? const CircularProgressIndicator()
                        : Text(geminiProvider.response ?? ''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
