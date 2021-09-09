import 'dart:developer';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/utilities/forgot-password.dart';
import 'package:storage_cloud/screens/homeScreen.dart';
import 'package:storage_cloud/utilities/background.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/widgets/inputTile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:storage_cloud/widgets/size_config.dart';

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
  bool _login = false;
  bool validate() {
    if (formkey.currentState.validate()) {
      print("validated");
      return true;
    } else {
      print("not validated");
      Fluttertoast.showToast(
          msg: "Please check the required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: kContentColorDarkThemeColor,
          textColor: kWhite,
          fontSize: 1.9 * SizeConfig.textMultiplier);
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
        body: ModalProgressHUD(
          opacity: 0.4,
          progressIndicator: SpinKitSpinningLines(
            itemCount: 10,
            lineWidth: 8,
            color: Colors.black,
          ),
          inAsyncCall: _login,
          child: Stack(children: [
            Column(
              children: [
                Flexible(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'STORA',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9 * SizeConfig.textMultiplier,
                              fontFamily: 'Satisfy',
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: "G",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9 * SizeConfig.textMultiplier,
                              ),
                            ),
                            TextSpan(
                              text: "E",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9 * SizeConfig.textMultiplier,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Form(
                  key: formkey,
                  child: Padding(
                    padding: outputTileP,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InputTile(
                          startIcon: Icon(Icons.email, color: kPrimaryColor,size: 6 * SizeConfig.imageSizeMultiplier),
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
                          startIcon: Icon(Icons.lock, color: kPrimaryColor,size: 6 * SizeConfig.imageSizeMultiplier),
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
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kPrimaryColor,size:6 * SizeConfig.imageSizeMultiplier,),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 1.9 * SizeConfig.textMultiplier),
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
                                  padding:
                                      EdgeInsets.all(kDefaultButtonPadding),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        kDefaultBorderRadius),
                                  ),
                                ),
                                onPressed: () async {
                                  if (validate()) {
                                    var msg;
                                    setState(() {
                                      _login = true;
                                    });

                                    User user = User.a(
                                        email: email, password: password);
                                    var listResponse = await user.logInUser();
                                    log(listResponse.toString(), name: "list");
                                    if (listResponse.length != 1) {
                                      var response = listResponse[1];

                                      logInCookie = listResponse[0];

                                      var ok = response["message"];
                                      print(
                                          "this is well==================$ok");
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
                                        setState(() {
                                          _login = false;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                HomeScreen(
                                                    cookie: logInCookie,
                                                    email: email,
                                                    view: false),
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
                                        fontSize:
                                            2.2 * SizeConfig.textMultiplier,
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                          fontSize: 1.9 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 1.9 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w700),
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
      ),
    );
  }
}
