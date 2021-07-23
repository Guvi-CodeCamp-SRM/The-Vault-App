import 'package:storage_cloud/services/networking.dart';

class User {
  String email;
  String password;
  String name;
  String cpassword;
  String file;

  User.a({this.email, this.password});
  User.b({this.email, this.password, this.name});
  User.c({this.file});

  Future<dynamic> fileUpload() async {
    var response =
        await ApiBaseHelper().post("files/upload", '{"file":"$file"}');
    return response;
  }

  Future<dynamic> registerUser() async {
    var response = await ApiBaseHelper().post("register",
        '{"name":"$name","email":"$email","password":"$password","cpassword":"$password"}');

    return response;
  }

  Future<dynamic> logInUser() async {
    var response = await ApiBaseHelper()
        .post('login', '{"email":"$email","password":"$password"}');
    return response;
  }
}
