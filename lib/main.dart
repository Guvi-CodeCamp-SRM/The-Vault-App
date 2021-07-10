import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storage_cloud/screens/create-new-account.dart';
import 'package:storage_cloud/screens/forgot-password.dart';
import 'package:storage_cloud/screens/homeScreen.dart';
import 'package:storage_cloud/screens/loginScreen.dart';
import 'package:storage_cloud/widgets/Grid.dart';

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
        '/Grids': (context) => Grid(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
