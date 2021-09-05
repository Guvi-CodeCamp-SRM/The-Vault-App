import 'package:flutter/material.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/utilities/drawer.dart';
import 'package:storage_cloud/widgets/FabButton.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:storage_cloud/widgets/Grid.dart';
import 'package:storage_cloud/widgets/Search.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  var cookie;
  String email;
  bool view;
  HomeScreen(
      {@required this.cookie, @required this.email, @required this.view});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  bool _searching = false;

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatButton(fabKey: fabKey, cookie: widget.cookie),
      appBar: AppBar(
        elevation: isDrawerOpen ? 15 : 12,
        shadowColor: isDrawerOpen ? Colors.white : Colors.black87,
        backgroundColor: kPrimaryColor,
        leading: isDrawerOpen
            ? GestureDetector(
                child: Icon(Icons.close),
                onTap: () {
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    isDrawerOpen = false;
                  });
                },
              )
            : GestureDetector(
                child: Icon(Icons.menu),
                onTap: () {
                  setState(() {
                    xOffset = 290;
                    yOffset = 80;
                    isDrawerOpen = true;
                  });
                },
              ),
        title: Center(
          child: _searching
              ? SearchBar(
                  isSearching: _searching,
                )
              : widget.view
                  ? Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey.shade100,
                      ),
                    )
                  : Text(
                      'My Drive',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey.shade100,
                        fontFamily: 'Pacifico'
                      ),
                    ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _searching = !_searching;
              });
            },
            tooltip: 'Search',
          ),
        ],
      ),
      body: Stack(children: [
        DrawerScreen(cookie: widget.cookie, email: widget.email),
        AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(isDrawerOpen ? 0.85 : 1.00)
              ..rotateZ(isDrawerOpen ? -50 : 0),
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(40)
                  : BorderRadius.circular(0),
            ),
            child: Grid(
              cookie: widget.cookie,
              view: widget.view,
            )),
      ]),
    );
  }
}
