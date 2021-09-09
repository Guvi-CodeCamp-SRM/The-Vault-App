import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/utilities/background.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/widgets/inputTile.dart';
import 'package:storage_cloud/widgets/size_config.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String name;

  String email;

  String password;

  String passwordTwo;

  bool _isObscure = true;

  bool _isObscureTwo = true;

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
          timeInSecForIosWeb: 1,
          backgroundColor: kContentColorDarkThemeColor,
          textColor: kWhite,
          fontSize: 16.0);
      return false;
    }
  }

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
    }

    EdgeInsetsGeometry outputTileP = inputTilePadding();
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Flexible(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.blue[900].withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: formkey,
                    child: Padding(
                      padding: outputTileP,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InputTile(
                            startIcon: Icon(Icons.person, color: kPrimaryColor),
                            setValidator: (value) {
                              if (value.isEmpty) {
                                return "Required";
                              } else {
                                return null;
                              }
                            },
                            inputType: "Enter Name",
                            callBack: (value) {
                              name = value;
                              print(name);
                            },
                          ),
                          SizedBox(height: 20.0),
                          InputTile(
                            startIcon:
                                Icon(Icons.mail_rounded, color: kPrimaryColor),
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
                          InputTile(
                            startIcon: Icon(Icons.lock, color: kPrimaryColor),
                            inputType: "Enter Password",
                            callBack: (value) {
                              password = value;
                              print(password);
                            },
                            setValidator: (value) {
                              if (value.isEmpty) {
                                return "Required";
                              } else if (password != passwordTwo) {
                                return "passwords do not match";
                              } else {
                                return null;
                              }
                            },
                            isObscure: _isObscure,
                            tileIcon: IconButton(
                                icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: kPrimaryColor),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                          ),
                          SizedBox(height: 20.0),
                          InputTile(
                            startIcon: Icon(Icons.lock, color: kPrimaryColor),
                            inputType: "Confirm Password",
                            callBack: (value) {
                              passwordTwo = value;
                              print(passwordTwo);
                            },
                            setValidator: (value) {
                              if (value.isEmpty) {
                                return "Required";
                              } else if (password != passwordTwo) {
                                return "passwords do not match";
                              } else {
                                return null;
                              }
                            },
                            isObscure: _isObscureTwo,
                            tileIcon: IconButton(
                                icon: Icon(
                                    _isObscureTwo
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: kPrimaryColor),
                                onPressed: () {
                                  setState(() {
                                    _isObscureTwo = !_isObscureTwo;
                                  });
                                }),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                    "Register",
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
                                      User user = User.b(
                                          name: name,
                                          email: email,
                                          password: password);
                                      var response = await user.registerUser();
                                      print("got $response");
                                      if (response['success'] == 'false' ||
                                          response['status'] == 'error') {
                                        msg = response['message'];
                                        print(msg);
                                        Fluttertoast.showToast(
                                            msg: "$msg",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor:
                                                kContentColorDarkThemeColor,
                                            textColor: kWhite,
                                            fontSize: 16.0);
                                      } else if (response['status'] == 'ok') {
                                        var msg = response['message'];
                                        print(msg);
                                        Fluttertoast.showToast(
                                            msg: "$msg",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                kContentColorDarkThemeColor,
                                            textColor: kWhite,
                                            fontSize: 16.0);
                                        Navigator.of(context)
                                            .popUntil(ModalRoute.withName("/"));
                                      } else {
                                        msg = response['message'];

                                        Fluttertoast.showToast(
                                            msg: "$msg",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
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
                      Text('Already a member?',
                          style: TextStyle(
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w700)),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName("/"));
                        },
                        child: Text('Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
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
            ),
          ),
        ]),
      ),
    );
  }
}
