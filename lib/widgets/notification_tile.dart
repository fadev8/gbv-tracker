import 'package:flutter/material.dart';
class NotificationTile extends StatelessWidget {

  final String date;
  final String message;
  final String sender;

  NotificationTile({@required this.date, @required this.message,@required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      color: Colors.white,
      child: ListTile(
        title: Text(message ?? ''),
        subtitle: Text(sender ?? ''),
        trailing: Text(date ?? ''),
      ),
    );
  }
}
