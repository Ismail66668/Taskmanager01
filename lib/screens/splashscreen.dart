import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmenager_app/screens/controller/authcontroller.dart';
import 'package:taskmenager_app/screens/login_screen.dart';
import 'package:taskmenager_app/screens/main_bottom_nev_bar.dart';
import 'package:taskmenager_app/utils/assetspath.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _movetoNextScreen();
  }

  Future<void> _movetoNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool logging = await Authcontroller.checkIfUserLoggedIn();

    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) =>
              logging ? const MainBottomNevBar() : const LoginScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Screenbackground(
        child: Center(
            child: SvgPicture.asset(
      AssetsPath.logoSvg,
      height: 80,
    )));
  }
}
