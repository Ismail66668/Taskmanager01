import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/models/loginmodels.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/screens/controller/authcontroller.dart';
import 'package:taskmenager_app/screens/main_bottom_nev_bar.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';
import '../widgets/showsnackbarmassag.dart';
import 'email_varification.dart';
import 'regestar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEControlor = TextEditingController();
  final TextEditingController _passwordlTEControlor = TextEditingController();
  final GlobalKey<FormState> _fromkye = GlobalKey<FormState>();
  bool _obsiqure = true;
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screenbackground(
            child: SafeArea(
                child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _fromkye,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              "Get Stat With",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "enter your email";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: _emailTEControlor,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "your password";
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              controller: _passwordlTEControlor,
              decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsiqure = !_obsiqure;
                        });
                      },
                      icon: Icon(_obsiqure
                          ? Icons.visibility
                          : Icons.visibility_off))),
              obscureText: _obsiqure,
            ),
            const SizedBox(
              height: 12,
            ),
            Visibility(
              visible: _loginInProgress == false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ElevatedButton(
                  onPressed: onPressLoging,
                  child: const Icon(Icons.arrow_circle_right_outlined)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: onTapForgetPassword,
                child: const Text("Forget Password")),
            const SizedBox(
              height: 12,
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
                      recognizer: TapGestureRecognizer()..onTap = onTabSinUp),
                ]))
          ],
        ),
      ),
    ))));
  }

  void onPressLoging() {
    if (_fromkye.currentState!.validate()) {
      _loging();
    } else {}
  }

  Future<void> _loging() async {
    _loginInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'email': _emailTEControlor.text.trim(),
      'password': _passwordlTEControlor.text
    };

    NetworkResponse respons =
        await NetworkClient.postRequest(url: Urls.loginUrl, body: requestBody);

    _loginInProgress = false;
    setState(() {});

    if (respons.isSuccess) {
      LoginModels loginModels = LoginModels.fromJson(respons.data!);
      Authcontroller.saveUserInformation(
          loginModels.token, loginModels.userModel);

      showSnackBarMessage(context, 'User Login successfully!');

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNevBar(),
          ),
          (pdg) => false);
    } else {
      showSnackBarMessage(context, 'User Login Unsuccessfull !');
    }
  }

  void onTapForgetPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailVarification(),
        ));
  }

  void onTabSinUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegestarScreen(),
        ));
  }

  @override
  void dispose() {
    _emailTEControlor.dispose();
    _passwordlTEControlor.dispose();
    super.dispose();
  }
}
