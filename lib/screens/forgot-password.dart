import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storage_cloud/utilities/background.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/utilities/inputTile.dart';
import 'package:storage_cloud/utilities/pallete.dart';
import 'package:storage_cloud/widgets/background-image.dart';
import 'package:storage_cloud/widgets/rounded-button.dart';
import 'package:storage_cloud/widgets/text-field-input.dart';

class ForgotPassword extends StatelessWidget {
  String email;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    EdgeInsetsGeometry inputTilePadding() {
      if (isPortrait) {
        return EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width) / 12);
      } else {
        return EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width) / 4);
      }
      ;
    }

    ;
    EdgeInsetsGeometry outputTileP = inputTilePadding();
    return Container(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 1],
              colors: [Colors.black, kPrimaryColor]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 10),
            Form(
              key: formkey,
              child: Padding(
                padding: outputTileP,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InputTile(
                      startIcon: Icon(Icons.mail_rounded, color: kPrimaryColor),
                      callBack: (value) {
                        email = value;
                        print(email);
                      },
                      keyboard: TextInputType.emailAddress,
                      inputType: "Enter Email ",
                      isObscure: false,
                      setValidator: (value) {
                        if (value.isEmpty) {
                          return "Required";
                        } else if ((!EmailValidator.validate(value))) {
                          return "Enter a valid email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Text(
                              "Get OTP",
                              style: kButtonLightTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              padding: EdgeInsets.all(kDefaultButtonPadding),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultBorderRadius),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName("/"));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
