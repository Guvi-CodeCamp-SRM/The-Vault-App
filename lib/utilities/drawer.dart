import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/screens/profile.dart';
import 'constants.dart';

class DrawerScreen extends StatefulWidget {
  var cookie;
  DrawerScreen({@required this.cookie});
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Future<dynamic> userData() async {
    User user = User.d(widget.cookie);
    var response = await user.userProfile();
    print(response);
    return response;
  }

  var name, email;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Padding(
        padding: EdgeInsets.only(left: 30, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    'Username',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '20GB of 50Gb used',
                  style: TextStyle(
                      fontSize: 17, color: Colors.white.withOpacity(0.5)),
                ),
                SizedBox(height: 20),
                NewRow(
                  text: 'My Drive',
                  icon: Icons.home_outlined,
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Encrypted',
                  icon: Icons.folder_open_rounded,
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Recent',
                  icon: Icons.book_outlined,
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Favorites',
                  icon: Icons.favorite_border,
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(text: 'Shared', icon: Icons.chat_bubble_outline_rounded),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Settings',
                  icon: Icons.settings_outlined,
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  function: null,
                  text: 'Trash',
                  icon: Icons.delete_outline,
                ),
              ],
            ),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function function;

  const NewRow({
    Key key,
    this.icon,
    this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
