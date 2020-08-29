import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';

class AppInfoScreen extends StatefulWidget {
  static String id = "app_info_screen";
  @override
  _AppInfoScreenState createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Hero(
              tag: 'banner',
              child: Image.asset('images/banner.jpeg'),
            ),
            Container(
              color: Color(0xdf6ca0ba),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Center(child: Text('App Info',style: kBannerBottomTitle,)),
            )
          ],
        ),
      ),
    );
  }
}
