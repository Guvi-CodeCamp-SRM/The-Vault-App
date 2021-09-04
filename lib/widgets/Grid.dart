import 'dart:developer';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_cloud/models/fileData.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/screens/image.dart';
import 'package:storage_cloud/utilities/constants.dart';

// ignore: must_be_immutable

int refreshValue = 0;

class Grid extends StatefulWidget {
  bool view;
  var cookie;
  Grid({@required this.cookie, @required this.view});
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  // TODO: implement initState

  var x;
  List<FileData> _files;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> refresh() {
    return fileCaller().then((_newFile) {
      setState(() => _files = _newFile);
    });
  }

  Future<List<FileData>> fileCaller() async {
    Response response = await Dio().post("${baseUrl}files/viewall",
        options: Options(
          headers: {"cookie": "${widget.cookie}"},
        ),
        data: {});

    var finalResponse = response.data;
    log(finalResponse.toString(), name: "z");
    _files = [];

    if (widget.view) {
      for (var f in finalResponse) {
        if (f["fav"]) {
          FileData file = FileData(f["length"], f["uploadData"], f["filename"],
              f["contenType"], f["fav"]);
          _files.add(file);
        }
      }
    } else {
      for (var f in finalResponse) {
        FileData file = FileData(f["length"], f["uploadData"], f["filename"],
            f["contenType"], f["fav"]);
        _files.add(file);
      }
    }

    log(_files.toString(), name: "list");
    return _files;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorkey,
        onRefresh: refresh,
        child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: FutureBuilder(
              future: fileCaller(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(child: Center(child: Text("Loading....")));
                } else {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Folder(
                            index: index,
                            folderName: snapshot.data[index].fileName,
                            cookie: widget.cookie,
                            fav: snapshot.data[index].fav);
                      });
                }
              },
            )),
      ),
    );
  }
}

class Folder extends StatefulWidget {
  final int index;
  final String folderName;
  final String cookie;
  final bool fav;

  const Folder({Key key, this.index, this.folderName, this.cookie, this.fav})
      : super(key: key);

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  Color _iconColor;
  var bytes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!widget.fav) {
      _iconColor = Colors.grey[400];
    } else {
      _iconColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey.shade200,
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: _iconColor,
                  ),
                  onPressed: () async {
                    User user = User.f(
                        fileName: widget.folderName, cookie: widget.cookie);
                    var response = await user.favToggle();
                    log(response.toString(), name: "favs");
                    if (response["status"] == "ok") {
                      setState(() {
                        if (_iconColor == Colors.red) {
                          _iconColor = Colors.grey[400];
                          Fluttertoast.showToast(
                              msg: "Removed to favs",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: kContentColorDarkThemeColor,
                              textColor: kWhite,
                              fontSize: 16.0);
                        } else {
                          _iconColor = Colors.red;
                          Fluttertoast.showToast(
                              msg: "Added to favs",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: kContentColorDarkThemeColor,
                              textColor: kWhite,
                              fontSize: 16.0);
                        }
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "ERROR:Please try later",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kContentColorDarkThemeColor,
                          textColor: kWhite,
                          fontSize: 16.0);
                    }
                  },
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: InkWell(
                        onTap: () async {},
                        child: Text(
                          "Download",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        "Share",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: InkWell(
                        onTap: () async {
                          User user = User.f(
                              fileName: widget.folderName,
                              cookie: widget.cookie);
                          var response = await user.fileDelete();
                          log(response.toString(), name: "delete");
                          if (response["success"] == true) {
                            Fluttertoast.showToast(
                                msg: "File deleted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: kContentColorDarkThemeColor,
                                textColor: kWhite,
                                fontSize: 16.0);
                            setState(() {});
                          } else {
                            Fluttertoast.showToast(
                                msg: "could not delete",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 5,
                                backgroundColor: kContentColorDarkThemeColor,
                                textColor: kWhite,
                                fontSize: 16.0);
                          }
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                  icon: Icon(Icons.more_vert),
                  offset: Offset(0, 40),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                User user =
                    User.f(fileName: widget.folderName, cookie: widget.cookie);
                bytes = await user.fileView();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => PageI(
                      bytes: bytes,
                    ),
                  ),
                );
                // log(response.toString(), name: "view");
                // log(widget.folderName.toString(), name: "name");
              },
              child:
                  //  if(bytes==null){
                  Icon(Icons.folder,
                      size: ((MediaQuery.of(context).size.width) / 3.5)),
              // }else{Image.memory(bytes)}
            ),
            Container(),
            Text(
              widget.folderName.substring(12),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
