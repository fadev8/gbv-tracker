import 'package:flutter/material.dart';
import 'package:gbv_tracker/screens/login_screen.dart';

void main() {
  runApp(GBVApp());
}

class GBVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
      },
    );
  }
}
