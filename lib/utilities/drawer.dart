import 'package:flutter/material.dart';
import 'package:storage_cloud/models/newRow.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/screens/favScreen.dart';
import 'package:storage_cloud/screens/homeScreen.dart';
import 'package:storage_cloud/screens/profile.dart';
import 'constants.dart';

// ignore: must_be_immutable
class DrawerScreen extends StatefulWidget {
  var cookie, email;
  DrawerScreen({@required this.cookie, this.email});
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  void userData() async {
    User user = User.d(widget.cookie);
    var response = await user.spaceUsed();
    print(response);

    if (response["status"] == "ok" && response["size"] != null) {
      space = response["size"];
    } else {
      space = 0;
    }
  }

  var name, email, space;

  @override
  void initState() {
    super.initState();
    userData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Padding(
        padding: EdgeInsets.only(left: 30, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: kPrimaryColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GestureDetector(
                        onTap: () async {
                          var msg;
                          User user = User.d(widget.cookie);
                          var response = await user.userProfile();

                          var ok = response["message"];
                          print("this is well==================$ok");
                          if (response["status"] == "error") {
                            msg = response["message"];
                            print("line 2 ======================$msg");
                          } else if (response["status"] == "ok") {
                            msg = response["message"];
                            name = response["data"]["name"];
                            email = response["data"]["email"];
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => Profile(
                                    cookie: widget.cookie,
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
                        },
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.email.toString().split("@")[0]}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$space used',
                    style: TextStyle(
                        fontSize: 17, color: Colors.white.withOpacity(0.5)),
                  ),
                  SizedBox(height: 30),
                  NewRow(
                      text: 'My Drive',
                      icon: Icons.home_outlined,
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                HomeScreen(cookie: widget.cookie, email: email),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 30,
                  ),

                  NewRow(
                      text: 'Favorites',
                      icon: Icons.favorite_border,
                      function: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                FavScreen(cookie: widget.cookie, email: email),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  // NewRow(
                  //   text: 'Encrypted',
                  //   icon: Icons.folder_open_rounded,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // NewRow(
                  //   text: 'Recent',
                  //   icon: Icons.book_outlined,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // NewRow(text: 'Shared', icon: Icons.chat_bubble_outline_rounded),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // NewRow(
                  //   text: 'Settings',
                  //   icon: Icons.settings_outlined,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // NewRow(
                  //   function: null,
                  //   text: 'Trash',
                  //   icon: Icons.delete_outline,
                  // ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                var msg;
                User user = User.d(widget.cookie);
                var response = await user.logoutProfile();
                print(response);
                var ok = response["message"];
                print("this is well==================$ok");
                if (response["status"] == "error") {
                  msg = response["message"];
                  print("line 2 ======================$msg");
                } else if (response["status"] == "ok") {
                  msg = response["message"];

                  Navigator.pop(context);
                } else {
                  msg = response["message"];
                  var success = response["success"];
                  print(
                      "line 3=========================$msg\nsuccess is $success");
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                }
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log out',
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
