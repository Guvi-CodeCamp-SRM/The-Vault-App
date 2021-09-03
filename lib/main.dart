import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:storage_cloud/utilities/constants.dart';
import 'screens/create-new-account.dart';
import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';
import 'utilities/forgot-password.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STORAGE',
      theme: ThemeData(
        popupMenuTheme: PopupMenuThemeData(color: Colors.grey[100]),
        shadowColor: kPrimaryColor,
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
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
}
