import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'dart:convert' as convert;

import 'package:storage_cloud/services/networking.dart';

class Preview {
  var response;
}


   // if (response.contentLength == 0) {
        //   return;
        // }
        // Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
        // String tempPath = tempDir.path;
        // print(tempDir.path);
        // final Directory directory =
        //     await Directory('$tempPath/CapturedImages').create(recursive: true);
        // PermissionStatus permissionResult =
        //     await Permission.;
        // if (permissionResult == PermissionStatus.granted) {
        // code of read or write file in external storage (SD card)
        // File file = new File('$tempPath/imageTTT.png');
        // await file.writeAsBytes(response.bodyBytes);
        // } else {
        //   print("not working");
        // }

        // Uint8List bytes = base64.decode(response.body);
        // var file = File(image);

        // await file.writeAsBytes(bytes);