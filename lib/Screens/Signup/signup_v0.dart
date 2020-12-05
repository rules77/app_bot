import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesis_project/Screens/Login/login_screen.dart';
import 'package:thesis_project/Screens/Login/login_screen_v0.dart' as loginv0;
import 'package:thesis_project/Screens/MenuDashboard/home.dart';
import 'package:thesis_project/Screens/Signup/components/background.dart';
import 'package:thesis_project/components/already_have_an_account_check.dart';
import 'package:thesis_project/components/rounded_button.dart';
import 'package:thesis_project/components/text_field_container.dart';

import '../../constants.dart';
import 'components/or_divider.dart';
import 'components/social_icon.dart';

class SignUpv0 extends StatefulWidget {
  @override
  _SignUpv0State createState() => _SignUpv0State();
}

class _SignUpv0State extends State<SignUpv0> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //return Form(child: null)
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //body: Body(),
      //appBar: AppBar(),
      body: Background(
              child: SingleChildScrollView(
                              child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Registro",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
                TextFieldContainer(
                    child: TextFormField(
                    validator: (input){
                      if(input.isEmpty){
                        return 'Por favor ingresa un correo electrónico';
                      }
                    },
                    onSaved: (input)=> _email = input,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      //labelText: 'Email',
                      hintText: 'Tu correo electrónico',
                      border: InputBorder.none,
                    ),
                    onChanged: (value){},
                  ),
                ),
                TextFieldContainer(
                    child: TextFormField(
                    validator: (input){
                      if(input.length < 6){
                        return 'La contraseña debe ser de al menos 6 caracteres';
                      }
                    },
                    onSaved: (input)=> _password = input,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: kPrimaryColor,
                      ),
                      border: InputBorder.none,
                      //labelText: 'Password',
                      hintText: 'Contraseña',
                    ),
                    obscureText: true,
                    onChanged: (value){},
                  ),
                ),
                RoundedButton(
                  text: "Registrarse",
                  press: signUp,
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return loginv0.LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                ),
                //RaisedButton(
                //  onPressed: signUp,
                //  child: Text('Sign up'),
                //),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Future<void> signUp() async{
    //TODO validate fields
    final formState = _formKey.currentState;
    if(formState.validate()){
      //TODO login to firebase
      formState.save();
      try{
      UserCredential user = await FirebaseAuth.
       instance.createUserWithEmailAndPassword(email: _email, password: _password);
       user.user.sendEmailVerification();
       //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(user: user)));
       Navigator.of(context).pop();
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginv0.LoginScreen()));
      }catch(e){
        print(e.message);
      }
    }
  }
}