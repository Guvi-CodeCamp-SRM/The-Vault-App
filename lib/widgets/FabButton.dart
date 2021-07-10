import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
        ),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            alignment: Alignment.bottomRight,
            ringDiameter: 350.0,
            ringWidth: 150.0,
            ringColor: Colors.white,
            fabSize: 60.0,
            fabElevation: 8.0,
            fabIconBorder: CircleBorder(),
            fabColor: Colors.orangeAccent,
            fabOpenIcon: Icon(Icons.menu_open, color: Colors.white),
            fabCloseIcon: Icon(Icons.close, color: Colors.black),
            fabMargin: const EdgeInsets.all(16.0),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            onDisplayChange: (isOpen) {},
            children: <Widget>[
              RawMaterialButton(
                fillColor: Colors.black,
                onPressed: () {},
                shape: CircleBorder(),
                padding: const EdgeInsets.all(18.0),
                child: Icon(Icons.folder,color: Colors.white),
              ),
              RawMaterialButton(
                fillColor: Colors.deepPurple,
                onPressed: () {},
                shape: CircleBorder(),
                padding: const EdgeInsets.all(18.0),
                child: Icon(Icons.upload_file, color: Colors.white),
              ),
              RawMaterialButton(
                fillColor: Colors.red,
                onPressed: () {},
                shape: CircleBorder(),
                padding: const EdgeInsets.all(18.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}