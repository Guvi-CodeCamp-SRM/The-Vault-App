import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:storage_cloud/models/fileData.dart';
import 'package:storage_cloud/utilities/constants.dart';

class Grid extends StatefulWidget {
  var cookie;
  Grid({@required this.cookie});
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  var fileData;
  dynamic fileCaller() async {
    var jsonResponse = await Dio().post("${baseUrl}files/viewall",
        options: Options(
          headers: {"cookie": "${widget.cookie}"},
        ),
        data: {});
    print("File Upload response:$jsonResponse");
    print(jsonResponse.statusCode);
    print(jsonResponse.data);
    print(jsonResponse.data.length);

    print(jsonResponse.runtimeType);
    log(jsonResponse.runtimeType.toString(), name: "dataType");
    return jsonResponse;
  }

  @override
  void initState() {
    fileCaller();
    print("--------------------");
    print(fileData);
    print("--------------------");
    log(fileData.toString(), name: "fileD");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(1, (index) {
            return GestureDetector(
              onTap: () {
                var data = fileCaller();
              },
              child: Center(
                child: Card(
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      Icon(Icons.folder,
                          size: ((MediaQuery.of(context).size.width) / 5)),
                      Container(),
                      Text(
                        'FOLDER',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
