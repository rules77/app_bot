import 'package:flutter/material.dart';
import 'package:thesis_project/components/text_field_container.dart';
import 'package:thesis_project/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String _email;
    return TextFieldContainer(
      child: TextField(
        //validator: (input){
        //  if(input.isEmpty){
        //    return 'Please type an email';
        //  }
        //},
        //onSaved: (input)=> _email = input,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
