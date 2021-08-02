import 'package:flutter/material.dart';
import 'constants.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
                        onTap: () {
                          Navigator.pushNamed(context, '/Profile');
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
