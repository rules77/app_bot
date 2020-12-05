import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

class VistaChat extends StatefulWidget {
  @override
  _VistaChatState createState() => _VistaChatState();
}

class _VistaChatState extends State<VistaChat> {
  
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState(){
    super.initState();
    _speech = stt.SpeechToText();
  }
  
  final FlutterTts flutterTts = FlutterTts();
  
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  static const String BOT_URL =
      "http://depressionbotauxiliar.herokuapp.com/bot";

  TextEditingController _queryController = TextEditingController();

  speak(String text) async{
    print(await flutterTts.getLanguages);
    await flutterTts.setLanguage("es-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chatbot"),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                return _buildItem(_data[index], animation, index);
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.message,
                  color: Colors.greenAccent,
                ),
                hintText: "Escribe tu mensaje aquí",
              ),
              controller: _queryController,
              textInputAction: TextInputAction.send,
              onSubmitted: (msg) {
                this._getResponse();
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }

  void _listen() async{
    if(!_isListening){
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if(available){
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) => setState((){
            _text = val.recognizedWords;
            //print(_text);
            _queryController.text = val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence > 0){
              _confidence = val.confidence;
            }
          }),
        );
      }
    }
    else{
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  http.Client _getClient() {
    return http.Client();
  }

  void _getResponse() {
    if (_queryController.text.length > 0) {
      this._insertSingleItem(_queryController.text);
      var client = _getClient();
      try {
        client.post(
          BOT_URL,
          body: {"query": _queryController.text},
        )..then((response) {
            Map<String, dynamic> data = jsonDecode(response.body);
            _insertSingleItem(data['response'] + "<bot>");
          });
      } catch (e) {
        print("Failed -> $e");
      } finally {
        client.close();
        _queryController.clear();
      }
    }
  }

  void _insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState.insertItem(_data.length - 1);
  }

  Widget _buildItem(String item, Animation animation, int index) {
    bool mine = item.endsWith("<bot>");
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          alignment: mine ? Alignment.topLeft : Alignment.topRight,
          child: InkWell(
              child: Bubble(
                child: Text(item.replaceAll("<bot>", "")),
                color: mine ? Colors.blue : Colors.indigo,
                padding: BubbleEdges.all(10),
            ),
            onTap: () => speak(item.replaceAll("<bot>", "")),
          ),
        ),
      ),
    );
  }
}
