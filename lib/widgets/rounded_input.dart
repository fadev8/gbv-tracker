import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  //private properties
  final Function onChanged;
  final String hint;
  final bool obscureText;
  final TextEditingController controller ;
  final TextInputType inputType;


  RoundedInput({this.inputType, @required this.onChanged, this.hint,this.controller, this.obscureText });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),

        child: Container(
          child: TextField(
            keyboardType: inputType,
            controller: controller,
            textAlign: TextAlign.center,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent
                )
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            ),
          ),
        ),
      )
    );
  }
}
