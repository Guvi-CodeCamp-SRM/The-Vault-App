import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/screens/profile.dart';
import 'package:storage_cloud/utilities/background.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/widgets/inputTile.dart';

// ignore: must_be_immutable
class ProfileUpdate extends StatefulWidget {
  String cookie;

  ProfileUpdate({@required this.cookie});
  @override
  State<ProfileUpdate> createState() => _ProfileUpdate();
}

class _ProfileUpdate extends State<ProfileUpdate> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String name;

  String email;

  bool _updating = false;
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
          inAsyncCall: _updating,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 35,
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          // padding: EdgeInsets.all(2.0),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 90),
                      Form(
                        key: formkey,
                        child: Padding(
                          padding: outputTileP,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InputTile(
                                startIcon:
                                    Icon(Icons.person, color: kPrimaryColor),
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
                                startIcon: Icon(Icons.mail_rounded,
                                    color: kPrimaryColor),
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
                                  } else if ((!EmailValidator.validate(
                                      value))) {
                                    return "Enter a valid email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 40.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text(
                                        "Update",
                                        style: kButtonLightTextStyle,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor,
                                        padding: EdgeInsets.all(
                                            kDefaultButtonPadding),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              kDefaultBorderRadius),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (validate()) {
                                          setState(() {
                                            _updating = true;
                                          });
                                          var msg;
                                          User user = User.e(
                                            name: name,
                                            email: email,
                                            cookie: widget.cookie,
                                          );
                                          var response =
                                              await user.updateUser();
                                          setState(() {
                                            _updating = false;
                                          });
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
                                          } else if (response['success'] ==
                                              'true') {
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
                                          } else {
                                            msg = response['message'];
                                            // ignore: unused_local_variable
                                            var success = response['success'];
                                            Fluttertoast.showToast(
                                                msg: "$msg",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    kContentColorDarkThemeColor,
                                                textColor: kWhite,
                                                fontSize: 16.0);

                                            User user = User.d(widget.cookie);
                                            var res = await user.userProfile();

                                            var ok = res["message"];
                                            print(
                                                "this is well==================$ok");
                                            if (res["status"] == "error") {
                                              msg = res["message"];
                                              print(
                                                  "line 2 ======================$msg");
                                            } else if (res["status"] == "ok") {
                                              msg = res["message"];
                                              name = res["data"]["name"];
                                              email = res["data"]["email"];
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          Profile(
                                                              cookie:
                                                                  widget.cookie,
                                                              name: name,
                                                              email: email),
                                                ),
                                              );
                                            } else {
                                              msg = response["message"];
                                              var success = response["success"];
                                              print(
                                                  "line 3=========================$msg\nsuccess is $success");
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
