import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:thesis_project/Screens/Login/login_screen.dart';
import 'package:thesis_project/Screens/Login/login_screen_v0.dart' as screenv0;
//import 'package:flutter/rendering.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:thesis_project/Screens/Welcome/welcome_screen.dart';
import 'package:thesis_project/Screens/Welcome/welcome_screen_v0.dart';
import 'package:thesis_project/VistaChat.dart';
import 'package:thesis_project/constants.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'griddashboard.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RootApp());
  //runApp(MyApp());
  //runApp(MaterialApp(
  //  home: Home(),
  //));
}

//class MyApp extends StatelessWidget {
// This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
// is not restarted.
//        primarySwatch: Colors.blue,
// This makes the visual density adapt to the platform that you run
// the app on. For desktop platforms, the controls will be smaller and
// closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

//  final String title;

//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}

//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;

//  void _incrementCounter() {
//    setState(() {
// This call to setState tells the Flutter framework that something has
// changed in this State, which causes it to rerun the build method below
// so that the display can reflect the updated values. If we changed
// _counter without calling setState(), then the build method would not be
// called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }

//  @override
//  Widget build(BuildContext context) {
// This method is rerun every time setState is called, for instance as done
// by the _incrementCounter method above.
//
// The Flutter framework has been optimized to make rerunning build methods
// fast, so that you can just rebuild anything that needs updating rather
// than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
// Center is a layout widget. It takes a single child and positions it
// in the middle of the parent.
//        child: Column(
// Column is also a layout widget. It takes a list of children and
// arranges them vertically. By default, it sizes itself to fit its
// children horizontally, and tries to be as tall as its parent.
//
// Invoke "debug painting" (press "p" in the console, choose the
// "Toggle Debug Paint" action from the Flutter Inspector in Android
// Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// to see the wireframe for each widget.
//
// Column has various properties to control how it sizes itself and
// how it positions its children. Here we use mainAxisAlignment to
// center the children vertically; the main axis here is the vertical
// axis because Columns are vertical (the cross axis would be
// horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: WelcomeScreen(),
      //home: screenv0.LoginScreen(),
      home: WelcomePage(),
      //home: SpeechScreen(),
      //home: TextToSpeech(),
      //home: VistaChat(),

    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String,HighlightedWord> _highlights = {
    'hola': HighlightedWord(
      onTap: () => print('hola'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'familia': HighlightedWord(
      onTap: () => print('familia'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'perfecto': HighlightedWord(
      onTap: () => print('perfecto'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
  };
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState(){
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.black,
             fontWeight: FontWeight.w400,
            ),
          ),
          //child: TextHighlight(
          //  text: _text, 
          //  words: _highlights,
          //  textStyle: const TextStyle(
          //    fontSize: 32.0,
          //    color: Colors.black,
          //    fontWeight: FontWeight.w400,
          //  ),
          //),
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
}


class TextToSpeech extends StatelessWidget{

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context){

    TextEditingController textEditingController = TextEditingController();

    speak(String text) async{
      print(await flutterTts.getLanguages);
      await flutterTts.setLanguage("es-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(text); 
    }

    return Container(
      alignment: Alignment.center,
      //child: RaisedButton(
        //child: Text("Press this button to say Hello."),
        //onPressed: () => speak(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: textEditingController,
              style: TextStyle(color: Colors.white),
            ),
            RaisedButton(
              child: Text("Press this button to say Hello."),
              onPressed: () => speak(textEditingController.text),
            ),
          ]
        ),
      //),
    );
  }
}