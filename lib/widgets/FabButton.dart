import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:storage_cloud/utilities/constants.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({
    Key key,
    @required this.fabKey,
  }) : super(key: key);

  final GlobalKey<FabCircularMenuState> fabKey;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => FabCircularMenu(
        key: fabKey,
        alignment: Alignment.bottomRight,
        ringDiameter: 300.0,
        ringWidth: 100.0,
        ringColor: Colors.transparent,
        fabSize: 60.0,
        fabElevation: 8.0,
        fabIconBorder: CircleBorder(),
        fabColor: kPrimaryColor,
        fabOpenIcon: Icon(Icons.menu_open, color: Colors.white),
        fabCloseIcon: Icon(Icons.close, color: Colors.white),
        fabMargin: const EdgeInsets.all(16.0),
        animationDuration: const Duration(milliseconds: 850),
        animationCurve: Curves.easeInOutCirc,
        onDisplayChange: (isOpen) {},
        children: <Widget>[
          RawMaterialButton(
            fillColor: Colors.black,
            onPressed: () {},
            shape: CircleBorder(),
            padding: const EdgeInsets.all(18.0),
            child: Icon(Icons.folder, color: Colors.white),
          ),
          RawMaterialButton(
            fillColor: Colors.deepPurple,
            onPressed: () {},
            shape: CircleBorder(),
            padding: const EdgeInsets.all(18.0),
            child: Icon(Icons.upload_file, color: Colors.white),
          ),
          RawMaterialButton(
            fillColor: Colors.blueAccent,
            onPressed: () {},
            shape: CircleBorder(),
            padding: const EdgeInsets.all(18.0),
            child: Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
