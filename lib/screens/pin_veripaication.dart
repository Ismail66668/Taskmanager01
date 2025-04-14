import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmenager_app/screens/email_varification.dart';
import 'package:taskmenager_app/screens/set_password.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVeripaication extends StatefulWidget {
  const PinVeripaication({super.key});

  @override
  State<PinVeripaication> createState() => _VaripiPinState();
}

class _VaripiPinState extends State<PinVeripaication> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              "A 6 Digite verification pin will send to your email adderss",
              style:
                  TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 14),
            ),
            const SizedBox(
              height: 36,
            ),
            PinCodeTextField(
              cursorColor: Colors.amber,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                  fieldOuterPadding: const EdgeInsets.only(top: 10),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveFillColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.white),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              enableActiveFill: true,
              controller: _controller,
              onCompleted: (v) {},
              beforeTextPaste: (text) {
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: onTab,
                child: const Icon(Icons.arrow_circle_right_outlined)),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black45),
                      children: [
                    const TextSpan(text: "Missing OTP ? "),
                    TextSpan(
                        text: " Go Back",
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = onTablogin),
                  ])),
            )
          ],
        ),
      )),
    );
  }

  void onTab() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SetPassword(),
        ));
  }

  void onTablogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailVarification(),
        ));
  }
}
