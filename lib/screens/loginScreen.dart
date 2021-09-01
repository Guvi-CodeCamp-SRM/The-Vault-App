import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/utilities/forgot-password.dart';
import 'package:storage_cloud/screens/homeScreen.dart';
import 'package:storage_cloud/utilities/background.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/widgets/inputTile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String email;

  String password;
  static var logInCookie;
  bool _isObscure = true;

  bool validate() {
    if (formkey.currentState.validate()) {
      print("validated");
      return true;
    }
    //else if (!password.contains(new RegExp(regexPass))) {
    //   print("not validated");
    //   Fluttertoast.showToast(
    //       msg:
    //           "Password must contain atleast 8 characters, 1 Uppercase, 1 Lowercase, 1 Digit and 1 Special Character/Symbol",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 3,
    //       backgroundColor: kContentColorDarkThemeColor,
    //       textColor: kWhite,
    //       fontSize: 16.0);
    //   return false;
    // }
    else {
      print("not validated");
      Fluttertoast.showToast(
          msg: "Please check the required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: kContentColorDarkThemeColor,
          textColor: kWhite,
          fontSize: 16.0);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    EdgeInsetsGeometry inputTilePadding() {
      if (isPortrait) {
        return EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width) / 12);
      } else {
        return EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width) / 4);
      }
    }

    EdgeInsetsGeometry outputTileP = inputTilePadding();
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Column(
            children: [
              Flexible(
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'STORA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                        children: [
                          TextSpan(
                            text: "G",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                            ),
                          ),
                          TextSpan(
                            text: "E",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Form(
                key: formkey,
                child: Padding(
                  padding: outputTileP,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InputTile(
                        startIcon: Icon(Icons.email, color: kPrimaryColor),
                        keyboard: TextInputType.emailAddress,
                        setValidator: (value) {
                          if (value.isEmpty) {
                            return "Required";
                          } else if ((!EmailValidator.validate(value))) {
                            return "Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        isObscure: false,
                        inputType: "Enter Email",
                        callBack: (value) {
                          email = value;
                          print(password);
                        },
                      ),
                      SizedBox(height: 20.0),
                      InputTile(
                        startIcon: Icon(Icons.lock, color: kPrimaryColor),
                        inputType: "Enter Password",
                        callBack: (value) {
                          password = value;
                        },
                        setValidator: (value) {
                          if (value.isEmpty) {
                            return "Required";
                          }
                          // else if (!password
                          //     .contains(new RegExp(regexPass))) {
                          //   return "Re-Enter";
                          // }
                          else {
                            return null;
                          }
                        },
                        isObscure: _isObscure,
                        tileIcon: IconButton(
                            icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: kPrimaryColor),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 13),
                        ),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                  child: ForgotPassword());
                            },
                          );
                        },
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                color: kPrimaryColor)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                "Enter",
                                style: kButtonLightTextStyle,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                padding: EdgeInsets.all(kDefaultButtonPadding),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
                                ),
                              ),
                              onPressed: () async {
                                if (validate()) {
                                  var msg;
                                  User user =
                                      User.a(email: email, password: password);
                                  var listResponse = await user.logInUser();
                                  log(listResponse.toString(), name: "list");
                                  if (listResponse.length != 1) {
                                    var response = listResponse[1];

                                    logInCookie = listResponse[0];

                                    var ok = response["message"];
                                    print("this is well==================$ok");
                                    if (response["status"] == "error") {
                                      msg = response["message"];
                                      print(
                                          "line 2 ======================$msg");
                                    } else if (response["status"] == "ok") {
                                      msg = response["message"];
                                      print(
                                          "line 2 ======================$msg");
                                      log(logInCookie, name: "loginc");
                                      print("login =================");
                                      print(logInCookie);
                                      print("login =================");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomeScreen(
                                                  cookie: logInCookie,
                                                  email: email),
                                        ),
                                      );
                                    } else {
                                      msg = response["message"];
                                      var success = response["success"];
                                      print(
                                          "line 3=========================$msg\nsuccess is $success");
                                    }
                                  } else {
                                    var response = listResponse[0];
                                    var msg = response["message"];
                                    Fluttertoast.showToast(
                                        msg: msg,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor:
                                            kContentColorDarkThemeColor,
                                        textColor: kWhite,
                                        fontSize: 16.0);
                                  }
                                }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 13),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/CreateNewAccount');
                    },
                    child: const Text('Register',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: kPrimaryColor)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
