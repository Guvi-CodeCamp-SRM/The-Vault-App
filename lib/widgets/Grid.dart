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
  var j;

  Future<List<FileData>> fileCaller() async {
    Response response = await Dio().post("${baseUrl}files/viewall",
        options: Options(
          headers: {"cookie": "${widget.cookie}"},
        ),
        data: {});

    var finalResponse = response.data;
    print(finalResponse[0]["length"].runtimeType);
    print(finalResponse[0]["uploadDate"].runtimeType);
    print(finalResponse[0]["filename"].runtimeType);
    print(finalResponse[0]["contentType"].runtimeType);
    List<FileData> files = [];
    for (var f in finalResponse) {
      FileData file = FileData(
          f["length"], f["uploadData"], f["filename"], f["contenType"]);
      files.add(file);
    }

    return files;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: FutureBuilder(
            future: fileCaller(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading")));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Card(
                            color: Colors.grey.shade200,
                            child: Column(
                              children: [
                                Icon(Icons.folder,
                                    size: ((MediaQuery.of(context).size.width) /
                                        5)),
                                Container(),
                                Text(
                                  snapshot.data[index].fileName.substring(12),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          )),
    );
  }
}


// GridView.count(
//           crossAxisCount: 3,
//           children: List.generate(1, (index) {
//             return GestureDetector(
//               onTap: () async {
//                 var data = await fileCaller();
//                 print(data);
//               },
//               child: Center(
//                 child: Card(
//                   color: Colors.grey.shade200,
//                   child: Column(
//                     children: [
//                       Icon(Icons.folder,
//                           size: ((MediaQuery.of(context).size.width) / 5)),
//                       Container(),
//                       Text(
//                         'FOLDER',
//                         style: Theme.of(context).textTheme.bodyText2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),