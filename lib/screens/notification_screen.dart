import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gbv_tracker/screens/login_screen.dart';
import 'package:gbv_tracker/widgets/logout_button.dart';
import 'package:gbv_tracker/widgets/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  static String id = 'notification-screen';
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  bool loadingData = false;
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.notifications_active),
          title: Text('Notifications'),
          actions: [
            LogoutButton(
              onPressed: (){
                //TODO Logout operation
                Navigator.pushNamed(context, LoginScreen.id);
              },
            )
          ],
        ),

        body: loadingData
            ? Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            valueColor:
            AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
        ) : Container(
          color: Color(0x22FFFFFF),
          child: ListView(
            padding: EdgeInsets.only(top: 8),
            controller: _controller,
            children: [
              NotificationTile(
                message: 'Message here',
                sender: 'by Jack',
                date: '${DateTime.now().month} - ${DateTime.now().year.toString()}',
              ),
              NotificationTile(
                message: 'Message here',
                sender: 'by Jules',
                date: '${DateTime.now().month} - ${DateTime.now().year.toString()}',
              ),

            ],
          ),
        ),

      ),
    );
  }
}
