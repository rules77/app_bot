import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget{
  final UserCredential user;
  
  const Home({Key key, @required this.user}):super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${widget.user.user.email}'),
      ),
    );
  }
}