import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesis_project/Screens/Login/components/background.dart';
import 'package:thesis_project/Screens/Login/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thesis_project/Screens/MenuDashboard/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thesis_project/Screens/MenuDashboard/menu_dashboard.dart';
import 'package:thesis_project/Screens/Signup/signup_v0.dart';
import 'package:thesis_project/components/already_have_an_account_check.dart';
import 'package:thesis_project/components/rounded_button.dart';
import 'package:thesis_project/components/text_field_container.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  "Ingresar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
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
                      hintText: 'Contraseña',
                      //labelText: 'Password',
                    ),
                    obscureText: true,
                    onChanged: (value){},
                  ),
                ),
                RoundedButton(
                  text: "Ingresar",
                  press: signIn,
                ),
                //RaisedButton(
                //  onPressed: signIn,
                //  child: Text('Sign in'),
                //),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
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
      ),
    );
  }

  Future<void> signIn() async{
    //TODO validate fields
    final formState = _formKey.currentState;
    if(formState.validate()){
      //TODO login to firebase
      formState.save();
      try{
      UserCredential user = await FirebaseAuth.
       instance.signInWithEmailAndPassword(email: _email, password: _password);
       Navigator.push(context, MaterialPageRoute(builder: (context)=> MenuDashboardScreen(user: user)));//Home(user: user)));
      }catch(e){
        print(e.message);
      }
    }
  }
}