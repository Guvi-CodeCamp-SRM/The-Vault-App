import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:storage_cloud/screens/profileUpdate.dart';
import 'package:storage_cloud/utilities/background.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/utilities/deleteAccount.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  var cookie, name, email;
  Profile({
    @required this.cookie,
    @required this.name,
    @required this.email,
  });

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  String name;

  String email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
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
                    SizedBox(height: size.height / 5 - 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 40,
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Colors.black,
                                ),
                                Text(
                                  '${widget.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  width: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.email,
                                  size: 35,
                                  color: Colors.black,
                                ),
                                // SizedBox(
                                //   width: 0,
                                // ),
                                Text(
                                  '${widget.email}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    child: Text(
                                      "Update",
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
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              ProfileUpdate(
                                                  cookie: widget.cookie),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                            child: DeleteAccount(
                                          cookie: widget.cookie,
                                        ));
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Delete",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
