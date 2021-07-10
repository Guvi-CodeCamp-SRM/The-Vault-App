import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:storage_cloud/utilities/constants.dart';

class ApiBaseHelper {
  bool status;
  Future<dynamic> post(String url, String body) async {
    print('Api Post, url $baseUrl$url');
    try {
      print(body);
      final response =
          await http.post(Uri.parse('$baseUrl$url'), body: body, headers: {
        "content-type": "application/json",
        "accept": "application/json",
      });
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 400) {
        var jsonResponse = convert.jsonDecode(response.body);
        print('$jsonResponse');
        return jsonResponse['body'];
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
