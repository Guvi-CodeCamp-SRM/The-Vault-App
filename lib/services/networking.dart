import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:storage_cloud/utilities/constants.dart';

class ApiBaseHelper {
  bool status;
  // Future<dynamic> post(String url, String body) async {
  //   print('Api Post, url $baseUrl$url');
  //   try {
  //     print(body);
  //     final response = await Dio().post('$baseUrl$url', data: body);
  //     print(response.statusCode);
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       print('$response');
  //       return response;
  //     }
  //     return {
  //       'success': 'no',
  //       'message': 'Request failed with status: ${response.statusCode}.'
  //     };
  //   } on SocketException {
  //     return {'success': 'no', 'message': 'Socket Exception.'};
  //   }
  // }
  // Future<dynamic> filePost(String url, String filePath) async {
  //   try {
  //     final response = await http.post("$baseUrl$url",
  //         headers: {"Content-type": "application/x-www-form-urlencoded"},
  //         body: filePath);
  //     print(response.statusCode);
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       var jsonResponse = convert.jsonDecode(response.body);
  //       print('$jsonResponse');
  //       return jsonResponse;
  //     }
  //     return {
  //       'success': 'no',
  //       'message': 'File Upload failed with status: ${response.statusCode}.'
  //     };
  //   } on SocketException {
  //     return {'status': 'no', 'message': 'Bad Internet connection'};
  //   }
  // }

  Future<dynamic> postLogin(String url, String body) async {
    print('Api Post, url $baseUrl$url');
    List value = [];
    try {
      print(body);
      final response =
          await http.post(Uri.parse('$baseUrl$url'), body: body, headers: {
        "content-type": "application/json",
        "accept": "application/json",
      });
      print(response.statusCode);
      print(response);
      log(response.headers.toString(), name: "ApiBaseHelper");
      value.add(response.headers["set-cookie"]);
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);
        print('$jsonResponse');
        value.add(jsonResponse);
        log(value.toString(), name: "list");
        return value;
      }
      return {
        'success': 'no',
        'message': 'Request failed with status: ${response.statusCode}.'
      };
    } on SocketException {
      return {'success': 'no', 'message': 'Socket Exception.'};
    }
  }

  Future<dynamic> post(String url, String body, cookie) async {
    print('Api Post, url $baseUrl$url');
    try {
      print(body);
      final response =
          await http.post(Uri.parse('$baseUrl$url'), body: body, headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "cookie": "$cookie"
      });
      print(response.statusCode);
      print(response);
      log(response.headers.toString(), name: "ApiBaseHelper");
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);
        print('$jsonResponse');
        return jsonResponse;
      }
      return {
        'success': 'no',
        'message': 'Request failed with status: ${response.statusCode}.'
      };
    } on SocketException {
      return {'success': 'no', 'message': 'Socket Exception.'};
    }
  }
}
