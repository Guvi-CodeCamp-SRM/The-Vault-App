import 'package:flutter/material.dart';

List<Widget> list = [
  Container(
    padding: const EdgeInsets.only(bottom: 8),
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text('File 1'),
            trailing: Icon(Icons.arrow_right_alt_outlined),
          ),
        ],
      ),
    ),
  ),
  Container(
    padding: const EdgeInsets.only(bottom: 8),
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text('File 2'),
            trailing: Icon(Icons.arrow_right_alt_outlined),
          ),
        ],
      ),
    ),
  ),
  Container(
    padding: const EdgeInsets.only(bottom: 8),
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text('File 3'),
            trailing: Icon(Icons.arrow_right_alt_outlined),
          ),
        ],
      ),
    ),
  ),
];