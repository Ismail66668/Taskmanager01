// ignore: file_names
import 'package:flutter/material.dart';
import 'package:taskmenager_app/screens/splashscreen.dart';

class Taskmenager extends StatefulWidget {
  const Taskmenager({super.key});
  static final GlobalKey<NavigatorState> navigatorKye =
      GlobalKey<NavigatorState>();

  @override
  State<Taskmenager> createState() => _TaskmenagerState();
}

class _TaskmenagerState extends State<Taskmenager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Taskmenager.navigatorKye,
      theme: ThemeData(
          colorSchemeSeed: Colors.green,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(18),
                fixedSize: const Size.fromWidth(double.maxFinite),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
              fillColor: Colors.white,
              filled: true,
              border: _zeroborder(),
              errorBorder: _zeroborder(),
              enabledBorder: _zeroborder())),
      home: const Splashscreen(),
    );
  }

  OutlineInputBorder _zeroborder() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
    );
  }
}
