import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/utilities/drawer.dart';
import 'package:storage_cloud/widgets/FabButton.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:storage_cloud/widgets/Grid.dart';
import 'package:storage_cloud/widgets/Search.dart';
import 'dart:convert' as convert;

class HomeScreen extends StatefulWidget {
  var cookie;
  HomeScreen({@required this.cookie});
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
  void initState() {
    // TODO: implement initState

    super.initState();
    // print(widget.cookie);
  }

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
                // child: Icon(Icons.arrow_back_ios),
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
              : Text(
                  'Storage',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey.shade100,
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
        DrawerScreen(cookie: widget.cookie),
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
            )),
      ]),
    );
  }
}









// SingleChildScrollView(
//             child: Container(
//               color: kPrimaryColor,
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 50,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 17),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         isDrawerOpen
//                             ? GestureDetector(
//                                 child: Icon(Icons.arrow_back_ios),
//                                 onTap: () {
//                                   setState(() {
//                                     xOffset = 0;
//                                     yOffset = 0;
//                                     isDrawerOpen = false;
//                                   });
//                                 },
//                               )
//                             : GestureDetector(
//                                 child: Icon(Icons.menu),
//                                 onTap: () {
//                                   setState(() {
//                                     xOffset = 290;
//                                     yOffset = 80;
//                                     isDrawerOpen = true;
//                                   });
//                                 },
//                               ),
//                         Text(
//                           'Storage',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.green,
//                               decoration: TextDecoration.none),
//                         ),
//                         Container(),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     height: double.maxFinite,
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 100,
//                         ),
//                         TextButton(
//                           child: Text("iiiinij"),
//                           onPressed: () {
//                             Navigator.pushNamed(context, '/Grids');
//                           },
//                         ),
//                         SizedBox(
//                           height: 100,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),