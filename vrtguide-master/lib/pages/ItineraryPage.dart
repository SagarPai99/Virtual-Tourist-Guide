import 'package:flutter/material.dart';
import 'package:vrtguide/helpers/ApiConnect.dart';
import 'package:vrtguide/pages/ItineraryTimelinePage.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
//import 'package:speech_recognition/speech_recognition.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

enum TtsState { playing, stopped }

class ItineraryPage extends StatefulWidget {
  createState() => ItineraryPageState();
}

class ItineraryPageState extends State<ItineraryPage>
    with AutomaticKeepAliveClientMixin<ItineraryPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  bool _hasSpeech = false;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  final SpeechToText speech = SpeechToText();
  bool isMicButtonPlaying = false;
  @override
  void initState() {
    super.initState();
    initSpeechState();
    initTts();
    isMicButtonPlaying = false;
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);

    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(onResult: this.resultListener);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {});
  }

  void cancelListening() {
    speech.cancel();
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    if (result.recognizedWords.trim().length > 0) {
      print("Updating lastwords...");
      this.lastWords = result.recognizedWords.trim();
      print("Updated " + this.lastWords);
    }
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = "$status";
    });
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                //onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.mic),
                  onPressed: () => _handleSubmitted()),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "lib/assets/credentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    String curr_text = response.getMessage() ??
        new CardDialogflow(response.getListMessage()[0]).title;
    print(curr_text);
    _newVoiceText = curr_text;
    _speak();
    ChatMessage message = new ChatMessage(
      text: curr_text,
      name: "Emma",
      type: false,
    );
    try{
      List js = json.decode(curr_text);
      List<int> lids = [];
      for( var ele in js ){
        lids.add(int.parse(ele.toString()));
      }
      Map data = await ApiConnect.forEachLandmark(lids);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItineraryTimelinePage(data)));
    }catch(e){
      print(e);
    }
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSubmitted() async {
    /* _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "User",//Put the name of the user
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);*/
    /*stt.SpeechToText speech = stt.SpeechToText();
    bool available = await speech.initialize( onStatus: statusListener, onError: errorListener );
    if ( available ) {
      speech.listen( onResult: resultListener );
    }
    else {
      print("The user has denied the use of speech recognition.");
    }
    // some time later...
    speech.stop();*/
    isMicButtonPlaying = !isMicButtonPlaying;
    print("Entering, mic status " + isMicButtonPlaying.toString());
    if (isMicButtonPlaying) {
      startListening();
      //Response(lastWords);
    } else {
      await Future.delayed(const Duration(seconds: 2));
      print("About to add " + this.lastWords);
      String said = this.lastWords;
      ChatMessage message = new ChatMessage(
        text: this.lastWords,
        name: "User", //Put the name of the user
        type: true,
      );
      setState(() {
        _messages.insert(0, message);
      });
      Response(said);
    }
  }

  bool needsRefresh;
  bool get wantKeepAlive => needsRefresh == null ? true : !needsRefresh;

  ItineraryPageState() {
    needsRefresh = false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
      ),
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              child: new Column(children: <Widget>[
                new Flexible(
                    child: new ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                )),
                Divider(
                  height: 1.0,
                ),
                Container(
                  padding: EdgeInsets.all(50.0),
                  child: Center(
                    child: Ink(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white, width: 4.0),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          _handleSubmitted();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.mic,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _onRefresh() async {
    needsRefresh = true;
    setState(() {});
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(
          child: new Text(
            'E',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      new Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text(this.name[0],
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
