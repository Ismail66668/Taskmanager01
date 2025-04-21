import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/screens/login_screen.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';
import '../data/service/netwark_client.dart';
import 'regestar.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key, required this.nEmail, required this.nOTP});
  final String nEmail, nOTP;

  @override
  State<SetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<SetPassword> {
  final TextEditingController _newPasswordTEControlar = TextEditingController();
  final TextEditingController _confrimPasswordTEControlar =
      TextEditingController();
  final GlobalKey<FormState> _passwordchangfromKye = GlobalKey<FormState>();
  bool isTap = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _passwordchangfromKye,
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
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return "Entar a new password";
                  } else if ((!RegExp(
                    r'^(?=.[A-Za-z])(?=.\d)(?=.[@$!%?&])[A-Za-z\d@$!%*?&]{8,}$',
                  ).hasMatch(value))) {
                    return "Set strong password";
                  }
                  return null;
                },
                controller: _newPasswordTEControlar,
                decoration: const InputDecoration(hintText: " Password"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                obscureText: isTap,
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return "Entar a new password";
                  }
                  return null;
                },
                controller: _confrimPasswordTEControlar,
                decoration: InputDecoration(
                    hintText: "confrim Password",
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isTap = !isTap;
                          });
                        },
                        icon: isTap
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility))),
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
                      onPressed: onsetPassword,
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
        ),
      )),
    );
  }

  void onTapPinVeripaction() {}

  void onTablogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegestarScreen(),
        ));
  }

  void onsetPassword() {
    if (_passwordchangfromKye.currentState!.validate()) {}
    _passWordSubmited();
  }

  Future<void> _passWordSubmited() async {
    Map<String, dynamic> requestBody = {
      "email": widget.nEmail,
      "OTP": widget.nOTP,
      "password": _newPasswordTEControlar.text,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.recuverPassword,
      body: requestBody,
    );
    if (response.isSuccess) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    } else {}
  }
}
