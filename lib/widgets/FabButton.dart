import 'dart:io';
import 'package:mime/mime.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_cloud/utilities/constants.dart';
import "package:dio/dio.dart";
import 'package:http_parser/http_parser.dart';

// ignore: must_be_immutable
class FloatButton extends StatelessWidget {
  FloatButton({
    Key key,
    @required this.fabKey,
    @required this.cookie,
  }) : super(key: key);
  var cookie;
  final GlobalKey<FabCircularMenuState> fabKey;

  get convert => null;

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
            onPressed: () async {
              FilePickerResult result = await FilePicker.platform.pickFiles();
              var msg;
              String type;
              if (result != null) {
                // ignore: unused_local_variable
                File file = File(result.files.single.path);
                print(result.paths.toString());
                type = lookupMimeType(result.files.first.path).toString();

                try {
                  FormData formData = new FormData.fromMap({
                    "file": await MultipartFile.fromFile(
                        result.files.first.path,
                        contentType:
                            MediaType(type.split("/")[0], type.split("/")[1]),
                        filename: result.files.first.name)
                  });
                  var jsonResponse = await Dio().post("${baseUrl}files/upload",
                      options: Options(headers: {
                        "cookie": "$cookie",
                      }, contentType: 'multipart/form-data'),
                      data: formData);
                  print("File Upload response:$jsonResponse");
                  print(jsonResponse.statusCode);
                  print(jsonResponse.data);
                  if (jsonResponse.statusCode == 200 ||
                      jsonResponse.statusCode == 400) {
                    Map<String, dynamic> response = jsonResponse.data;
                    print(response["status"].toString());
                    print('$response');

                    var ok = response["message"];
                    print("this is well==================$ok");
                    if (response["status"] == "error") {
                      msg = response["message"];
                      print("line 2 ======================$msg");
                    } else if (response["status"] == "ok") {
                      msg = response["message"];
                      print("line 2 ======================$msg");
                      Fluttertoast.showToast(
                          msg: "File has been uploaded succesfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kContentColorDarkThemeColor,
                          textColor: kWhite,
                          fontSize: 16.0);
                    } else {
                      msg = response["message"];

                      Fluttertoast.showToast(
                          msg: "ptani kya line hai ye",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kContentColorDarkThemeColor,
                          textColor: kWhite,
                          fontSize: 16.0);
                    }
                  }
                  return {
                    'success': 'no',
                    'message':
                        'Request failed with status: ${jsonResponse.statusCode}.'
                  };
                } catch (e) {
                  final errorMessage = DioExceptions.fromDioError(e).toString();
                  print(errorMessage);
                  print(e);
                }
              } else {
                // User canceled the picker
                Fluttertoast.showToast(
                    msg: "$msg",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 7,
                    backgroundColor: kContentColorDarkThemeColor,
                    textColor: kWhite,
                    fontSize: 16.0);
              }
            },
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

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        message =
            _handleError(dioError.response.statusCode, dioError.response.data);
        break;
      case DioErrorType.SEND_TIMEOUT:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong ,trying logging in again \n $error';
    }
  }

  @override
  String toString() => message;
}
