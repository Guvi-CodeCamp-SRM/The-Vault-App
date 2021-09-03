import 'package:flutter/material.dart';

class PageI extends StatefulWidget {
  var bytes;
  PageI({this.bytes});

  @override
  _PageIState createState() => _PageIState();
}

class _PageIState extends State<PageI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.memory(widget.bytes),
    );
  }
}
