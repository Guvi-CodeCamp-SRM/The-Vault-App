import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storage_cloud/models/fileData.dart';
import 'package:storage_cloud/models/user.dart';
import 'package:storage_cloud/screens/image.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'package:storage_cloud/widgets/size_config.dart';

// ignore: must_be_immutable

int refreshValue = 0;

// ignore: must_be_immutable
class Grid extends StatefulWidget {
  bool view;
  var cookie;
  Grid({@required this.cookie, @required this.view});
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
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
    log(response.toString(), name: "ATUL");
    var finalResponse = response.data;
    log(finalResponse.toString(), name: "z");
    _files = [];
    // var b = null;
    // for (var f in finalResponse) {
    //   b = await byteHandler(f["filename"]);
    // }
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

  Future byteHandler(String folderName) async {
    var bytes;
    User user = User.f(fileName: folderName, cookie: widget.cookie);
    bytes = await user.fileView();
    return bytes;
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
                  return Container(
                      child: Center(child: Text("Your Files are shown here")));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          // log(snapshot.data[index].b.toString(), name: "rise");
                          return Folder(
                            index: index,
                            folderName: snapshot.data[index].fileName,
                            cookie: widget.cookie,
                            fav: snapshot.data[index].fav,
                          );
                        }),
                  );
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
  // final byte;

  const Folder({Key key, this.index, this.folderName, this.cookie, this.fav})
      : super(key: key);

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  Color _iconColor;
  int x = 0;
  bool _process = false;
  Widget smallView;

  @override
  void initState() {
    super.initState();

    if (!widget.fav) {
      _iconColor = Colors.grey[400];
    } else {
      _iconColor = Colors.red;
    }
  }

  Future byteHandler(String folderName) async {
    var bytes;
    User user = User.f(fileName: folderName, cookie: widget.cookie);
    bytes = await user.fileView();
    return bytes;
  }

  Future<String> createFileFromString(
      String byte, String folderName, int x) async {
    Uint8List bytes = base64.decode(byte);
    String dir = (await getExternalStorageDirectory()).path;
    var y = folderName.split(".");
    File file;
    if (x == 0) {
      file = File("$dir/" + y[0].substring(12) + "." + y.last);
    } else {
      file = File("$dir/" + y[0].substring(12) + "($x)" + "." + y.last);
    }
    await file.writeAsBytes(bytes);
    x = x + 1;
    log(file.path.toString(), name: "path");
    return file.path;
  }

  Future<String> createPdfTempDir(
    String byte,
    String folderName,
  ) async {
    Uint8List bytes = base64.decode(byte);
    String dir = (await getTemporaryDirectory()).path;
    var y = folderName.split(".");
    File file;

    file = File("$dir/" + y[0].substring(12) + "." + y.last);

    await file.writeAsBytes(bytes);
    log(file.path.toString(), name: "path");
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    smallView =
        Icon(Icons.folder, size: ((MediaQuery.of(context).size.width) / 4));
    return Center(
      child: Card(
        color: Colors.grey.shade200,
        elevation: 4,
        child: ModalProgressHUD(
          inAsyncCall: _process,
          opacity: 0.4,
          progressIndicator: SpinKitDancingSquare(
            // itemCount: 10,
            // lineWidth: 8,
            color: Colors.white,
          ),
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
                      size: 6 * SizeConfig.imageSizeMultiplier,
                    ),
                    onPressed: () async {
                      setState(() {
                        _process = true;
                      });
                      User user = User.f(
                          fileName: widget.folderName, cookie: widget.cookie);
                      var response = await user.favToggle();
                      log(response.toString(), name: "favs");
                      setState(() {
                        _process = false;
                      });
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
                          onTap: () async {
                            setState(() {
                              _process = true;
                            });
                            var byte = await byteHandler(widget.folderName);
                            var fff = await createFileFromString(
                                byte, widget.folderName, x);
                            setState(() {
                              _process = false;
                            });
                            log(fff.toString(), name: "savePath");
                          },
                          child: Text(
                            "Download",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              _process = true;
                            });
                            User user = User.f(
                                fileName: widget.folderName,
                                cookie: widget.cookie);
                            var response = await user.fileDelete();
                            log(response.toString(), name: "delete");
                            setState(() {
                              _process = false;
                            });
                            if (response["success"] == true) {
                              Fluttertoast.showToast(
                                  msg: "File deleted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: kContentColorDarkThemeColor,
                                  textColor: kWhite,
                                  fontSize: 16.0);
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
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
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
                  setState(() {
                    _process = true;
                  });
                  var bytes;
                  User user = User.f(
                      fileName: widget.folderName, cookie: widget.cookie);
                  bytes = await user.fileView();

                  if (widget.folderName.split(".").last == "pdf" ||
                      widget.folderName.split(".").last == "doc") {
                    print("object1");

                    var pdfSavePath =
                        await createPdfTempDir(bytes, widget.folderName);
                    print(pdfSavePath);
                    // ignore: unused_local_variable
                    File doc = File(pdfSavePath);

                    print("object2");
                    setState(() {
                      _process = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PageI(
                            pdfPath: pdfSavePath,
                            name: widget.folderName.split(".").last),
                      ),
                    );
                  } else {
                    setState(() {
                      _process = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PageI(
                            bytes: bytes,
                            name: widget.folderName.split(".").last),
                      ),
                    );
                  }
                },
                child: smallView,
              ),
              // Container(),
              // SizedBox(height: 1),
              Text(
                widget.folderName.substring(12),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
              ),
              // Container(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
