import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gbv_tracker/main.dart';

class LogoutButton extends StatelessWidget {
  Function onPressed;

  LogoutButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.orange,
      icon: Icon(
        FontAwesomeIcons.signOutAlt,
      ),
      onPressed: onPressed,
    );
  }
}
