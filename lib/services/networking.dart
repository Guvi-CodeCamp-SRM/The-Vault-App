import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:storage_cloud/utilities/constants.dart';

class ApiBaseHelper {
  bool status;
  var s;
  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    print(status);
    s = status;
    print(s);
  }

  Future<dynamic> get(String url, cookie) async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl$url"), headers: {"cookie": "$cookie"});
      print(response.statusCode);
      print(response);
      log(response.headers.toString(), name: "getr");
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
      // log(response.body.toString(), name: "responseBody");
      log(response.headers.toString(), name: "ApiBaseHelper");
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);
        // String reply = await response.transform(utf8.decoder).join();
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

  Future<dynamic> postView(String url, String body, cookie) async {
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
      // log(response.body.toString(), name: "responseBody");
      // log(response.headers.toString(), name: "ApiBaseHelper");
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse["data"];
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
