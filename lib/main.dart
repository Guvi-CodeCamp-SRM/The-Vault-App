import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'screens/create-new-account.dart';
import 'screens/loginScreen.dart';
import 'utilities/forgot-password.dart';
import 'widgets/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints);
            return MaterialApp(
              title: 'STORAGE',
              theme: ThemeData(
                popupMenuTheme: PopupMenuThemeData(
                  color: Colors.grey[100],
                ),
                shadowColor: kPrimaryColor,
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => LoginScreen(),
                '/ForgotPassword': (context) => ForgotPassword(),
                '/CreateNewAccount': (context) => CreateNewAccount(),
              },
              debugShowCheckedModeBanner: false,
            );
          }
        );
      }
    );
  }
}
