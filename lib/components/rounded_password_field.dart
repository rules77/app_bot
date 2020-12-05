import 'package:flutter/material.dart';
import 'package:thesis_project/components/text_field_container.dart';
import 'package:thesis_project/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String _password;
    return TextFieldContainer(
      child: TextField(
        //validator: (input){
        //  if(input.length < 6){
        //    return 'Your password needs to be at least 6 characters';
        //  }
        //},
        //onSaved: (input) => _password = input,
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
