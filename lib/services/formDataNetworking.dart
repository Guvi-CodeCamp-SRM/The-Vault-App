import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'dart:convert' as convert;

class ApiProvider {
  Dio _dio;
  String aToken;
  ApiProvider.a({this.aToken});
  final BaseOptions options = new BaseOptions(
    baseUrl: "$baseUrl",
  );
  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() => _instance;

  ApiProvider._internal() {
    _dio = Dio(options);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      _dio.interceptors.requestLock.lock();

      options.headers["cookie"] = aToken;

      _dio.interceptors.requestLock.unlock();
      return options;
    }));
  }

  Future sendFile(FormData formData) async {
    var jsonResponse = await _dio.post("${baseUrl}files/upload",
        options: Options(contentType: 'multipart/form-data'), data: formData);
    print("File Upload response:$jsonResponse");
    print(jsonResponse.statusCode);
    if (jsonResponse.statusCode == 200 || jsonResponse.statusCode == 400) {
      var response = convert.jsonDecode(jsonResponse.data);

      print(response.data.toString());
      return response;
    }
  }

  Future recieveFile() async {
    var response = await _dio.post("${baseUrl}files/viewall", data: null);
  }
}
