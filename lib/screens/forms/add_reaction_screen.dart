import 'package:flutter/material.dart';
import 'package:gbv_tracker/services/case.dart';

class AddReactionScreen extends StatefulWidget {
  static String id = 'edit_case_screen';
  final Case cas;
  AddReactionScreen({@required this.cas});

  @override
  _AddReactionScreenState createState() => _AddReactionScreenState();
}

class _AddReactionScreenState extends State<AddReactionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Reaction'),
        ),
      ),
    );
  }
}
