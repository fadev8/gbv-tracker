import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';

class RoundedButton extends StatelessWidget {

  final String title;
  final Function onPress;
  final Color color;
  final double padding;
  final double minWidth;

  RoundedButton({this.minWidth, @required this.onPress, @required this.title, this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 2.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.lightBlueAccent,
        child: Container(
          child: MaterialButton(
            minWidth: minWidth ?? 30,
            onPressed: onPress,
            child: Text(title,style: kButtonTextStyle,),
          ),
        ),
      ),
    );
  }
}
