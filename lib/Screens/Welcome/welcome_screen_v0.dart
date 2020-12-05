import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesis_project/Screens/Login/login_screen_v0.dart';
import 'package:thesis_project/Screens/Signup/signup_v0.dart';
import 'package:thesis_project/Screens/Welcome/components/background.dart';
import 'package:thesis_project/components/rounded_button.dart';

import '../../constants.dart';
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('My firebase App'),
      //),
      body: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bienvenido al Chatbot",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: "Ingresar",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Registrarse",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpv0();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
      
      //Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        //children: <Widget>[
        //  RaisedButton(
        //    onPressed: NavigateToSignIn,
        //    child: Text('Sign in'),
        //  ),
        //  RaisedButton(
        //    onPressed: NavigateToSignUp,
        //    child: Text('Sign up'),
        //  ),
        //],
      //),
    );
  }

  void NavigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen(), fullscreenDialog: true));
  }
  void NavigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpv0(), fullscreenDialog: true));
  }
}