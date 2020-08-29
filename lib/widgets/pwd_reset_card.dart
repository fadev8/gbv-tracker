import 'package:flutter/material.dart';
import 'package:gbv_tracker/widgets/rounded_button.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';

class PWDResetCard extends StatelessWidget {

  final String title;
  final Function onChanged;
  final String placeHolder;
  final TextEditingController controller;
  final String buttonTitle;
  final double buttonWidth;
  final TextInputType inputType;

  PWDResetCard({this.inputType, @required this.title,@required this.buttonTitle, @required this.onChanged, this.placeHolder, @required this.controller, this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(fontSize: 18,),),
              SizedBox(height: 16,),

              RoundedInput(
                inputType: inputType,
                onChanged: onChanged,
                hint: placeHolder,
                controller: controller,
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: buttonWidth ?? 100,
                    child: RoundedButton(
                      padding: 0,
                      title: this.buttonTitle,
                      onPress: (){},
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
