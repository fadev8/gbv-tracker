import 'package:flutter/material.dart';
import 'package:gbv_tracker/services/case.dart';

class EditCaseScreen extends StatefulWidget {
  static String id = 'edit_case_screen';
  final Case cas;

  EditCaseScreen({@required this.cas});

  @override
  _EditCaseScreenState createState() => _EditCaseScreenState();
}

class _EditCaseScreenState extends State<EditCaseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Review / Edit Case'),
        ),
      ),
    );
  }
}
