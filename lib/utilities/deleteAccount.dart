import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/widgets/inputTile.dart';

// ignore: must_be_immutable
class DeleteAccount extends StatelessWidget {
  String password;
  String cookie;
  DeleteAccount({@required this.cookie});
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

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
                        password = value;
                      },
                      keyboard: TextInputType.emailAddress,
                      inputType: "Enter Password ",
                      isObscure: false,
                      setValidator: (value) {
                        if (value.isEmpty) {
                          return "Required";
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
                              "Delete Account",
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
                              if (validate()) {
                                User user = User.c(password: password);
                                var response = await user.deleteUser();
                                var msg;
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
          ],
        ),
      ),
    );
  }
}
