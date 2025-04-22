import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/screens/colours.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';



String _apiKey = "AIzaSyCJJDVNUWUoX53GXIKbKYD7Jam6BwqBrWo"; //import your own api key instead of comaiCodeApi

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,});


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatWidget(apiKey: _apiKey,),
    );
  }
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    required this.apiKey,
    super.key,
  });

  final String apiKey;
 

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  final List<String> _generatedGreetingMessage = <String>[];
  bool _loading = false;
  String contentToCopy = "";

  TextEditingController chatTextCont = TextEditingController();
  Widget inputTextField(){
    return Container(
      width: MediaQuery.sizeOf(context).width/.5,
      child: TextFormField(
                      controller: chatTextCont,
                      style: TextStyle(
                        color: yellowColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,),
                      decoration: InputDecoration(
                        hintText: "كيف اساعدك اليوم؟",
                        hintStyle: TextStyle(
                        color: yellowColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,),
                        fillColor: purpleColor,
                        filled: true,
                        suffixIcon:  IconButton(
                          onPressed: (){
                            _sendChatMessage(chatTextCont.text);
                          }, 
                          icon: Icon(
                            Icons.send,
                            color: yellowColor,
                          )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        ),
                      validator: (value) {
                         if (value == null || value.isEmpty) {
                            return "لا يمكن للحقل ان يكون فارغاً";
                          }
                        return null;
                  
                      },
                      enableInteractiveSelection: true,
                    ),
    );
  }

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: widget.apiKey,
    );
    _chat = _model.startChat();
    //  _sendChatMessage(widget.chatMessage);
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputTextField(),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: _apiKey.isNotEmpty
                ? ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, idx) {
                      final content = _generatedContent[idx];
                      contentToCopy = content.text!;
                      return MessageWidget(
                        text: content.text,
                        image: content.image,
                        isFromUser: content.fromUser,
                      );
                    },
                    itemCount: _generatedContent.length,
                  )
                : ListView(
                    children: const [
                      Text(
                        'No API key found. Please provide an API Key using '
                        "'--dart-define' to set the 'API_KEY' declaration.",
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox.square(dimension: 15),
                 //copy button
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: contentToCopy));
                      // copied successfully
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم النسخ بنجاح'),));
                      print(contentToCopy);
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                
               
                
                if (!_loading)
                  _generatedContent.isEmpty ? Container() : IconButton(
                    onPressed: () async {
                      _sendChatMessage(chatTextCont.text);
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                else
                  const CircularProgressIndicator(),
                  
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  
  Future<void> _greetingMessage(String message) async {
   
    try {
      _generatedGreetingMessage.add((message));
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      _generatedGreetingMessage.add((text!));

      if (text == null) { //this should be replaying null
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      // _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("هنالك خلل ما"),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('تم'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return 
    isFromUser ? Container() :
    Row(
      mainAxisAlignment:
          // isFromUser ? MainAxisAlignment.end : 
          MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 520),
                decoration: BoxDecoration(
                  color: isFromUser
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(children: [
                  if (text case final text?) MarkdownBody(data: text),
                  if (image case final image?) image,
                ]),
                ),
                ),
      ],
    );
  }
}