import 'package:flutter/material.dart';
import 'package:gbv_tracker/constants/constants.dart';
import 'package:gbv_tracker/widgets/pwd_reset_card.dart';
import 'package:gbv_tracker/widgets/rounded_input.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  static String id = "forgotten_password_screen";
  @override
  _ForgottenPasswordScreenState createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  String phoneNumber;
  bool isPhoneNumberSent = false;
  String oneTimeCode;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                  'Reset your password',
                  style: kBannerBottomTitle,
                )),
              ),
              //================== END OF BANNER ====================================
              Container(
                child: Center(
                  child: isPhoneNumberSent
                      ? PWDResetCard(
                          inputType: TextInputType.number,
                          controller: controller,
                          onChanged: () {},
                          title: 'Enter the SMS Code',
                          buttonTitle: 'Confirm',
                        )
                      : PWDResetCard(
                          controller: controller,
                          onChanged: () {},
                          title: 'Phone number',
                          placeHolder: '+250-43534io454',
                          buttonTitle: 'Next',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
