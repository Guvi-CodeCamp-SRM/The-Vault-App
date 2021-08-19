import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'screens/create-new-account.dart';
import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';
import 'utilities/forgot-password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STORAGE',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/HomeScreen': (context) => HomeScreen(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/CreateNewAccount': (context) => CreateNewAccount(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
