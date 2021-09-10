import "package:flutter/material.dart";
import 'package:storage_cloud/utilities/constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: kWhite,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: -17,
            child: Image.asset("assets/World.jpeg",
                fit: BoxFit.cover,
                scale: 1,
                width: size.width*1.1,
                height: size.height),
          ),
          child,
        ],
      ),
    );
  }
}
