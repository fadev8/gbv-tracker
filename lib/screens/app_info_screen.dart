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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'banner',
              child: Image.asset('images/banner.jpeg'),
            ),
            Container(
              color: Color(0xdf6ca0ba),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Center(
                  child: Text(
                'App Info',
                style: kBannerBottomTitle,
              )),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'App Version Code ...........................', style: TextStyle()),
                        TextSpan(text: 'GHw234g')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'App Version number ..............................', style: TextStyle()),
                        TextSpan(text: ' 0.0.1')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'App key ......................................', style: TextStyle()),
                        TextSpan(text: 'vbnd sjiud 02'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FlatButton(
                    color: Colors.green,
                    child: Text(
                      'Check for Updates',
                      style: kButtonTextStyle.copyWith(
                          fontWeight: FontWeight.normal),
                    ),
                    onPressed: () {
                      //TODO : Check updates
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Contact us :'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(),
                  ),

                  RichText(

                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'ActionAid ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        TextSpan(text: ' Rwanda')
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),

                  //email
                  RichText(

                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Email : ', style: TextStyle()),
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),

                  //website
                  RichText(

                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'web : ', style: TextStyle()),
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),

                  //Twitter
                  RichText(

                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Twitter : ', style: TextStyle()),
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),

                  //Facebook
                  RichText(

                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Facebook : ', style: TextStyle()),
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),

                  //Instagram
                  RichText(

                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Instagram : ', style: TextStyle()),
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),

                  //telephone
                  RichText(

                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Tel : ', style: TextStyle()),
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
