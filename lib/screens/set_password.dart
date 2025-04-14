import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmenager_app/screens/login_screen.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';
import 'regestar.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<SetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              "Set Password",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 24,
            ),
            const TextField(
              decoration: InputDecoration(hintText: " Password"),
            ),
            const SizedBox(
              height: 8,
            ),
            const TextField(
              decoration: InputDecoration(hintText: "confrim Password"),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
                width: double.infinity,
                child: TextButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: onTapPinVeripaction,
                    child: const Text(" confrim "))),
            const SizedBox(
              height: 24,
            ),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black45),
                    children: [
                  const TextSpan(text: "Have No Account ? "),
                  TextSpan(
                      text: " Sing Up",
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = onTablogin),
                ]))
          ],
        ),
      )),
    );
  }

  void onTapPinVeripaction() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  void onTablogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegestarScreen(),
        ));
  }
}
