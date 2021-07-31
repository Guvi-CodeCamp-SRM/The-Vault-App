// import 'dart:html' hide File;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_cloud/services/formDataNetworking.dart';
import 'package:storage_cloud/utilities/constants.dart';
// import "package:path/path.dart";
// import 'package:http/http.dart' as http;
import "package:dio/dio.dart";

class FloatButton extends StatelessWidget {
  var cookie;
  FloatButton({Key key, @required this.fabKey, @required this.cookie})
      : super(key: key);

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
              if (result != null) {
                File file = File(result.files.single.path);
                print(result.files.first.path);
                print("--------------------");
                String fileName = result.files.first.path;
                print(result.files.first.bytes);
                print("--------------------");
                print(fileName);

                try {
                  FormData formData = new FormData.fromMap({
                    "file": await MultipartFile.fromFile(
                        result.files.first.path,
                        filename: result.files.first.name)
                  });
                  ApiProvider xyz = ApiProvider.a(aToken: cookie);
                  var response = await xyz.sendFile(formData);
                  print('$response');

                  var msg;
                  var ok = response["message"];
                  print("this is well==================$ok");
                  if (response["status"] == "error") {
                    msg = response["message"];
                    print("line 2 ======================$msg");
                  } else if (response["status"] == "ok") {
                    msg = response["message"];
                    print("line 2 ======================$msg");
//TODO:File Uploaded
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
                } catch (e) {
                  final errorMessage = DioExceptions.fromDioError(e).toString();
                  print(errorMessage);
                }
              } else {
                // User canceled the picker

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
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}