import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/screens/login_screen.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';

import '../widgets/showsnackbarmassag.dart';

class RegestarScreen extends StatefulWidget {
  const RegestarScreen({super.key});

  @override
  State<RegestarScreen> createState() => _SingingScreenState();
}

class _SingingScreenState extends State<RegestarScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _registrationInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screenbackground(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Join With Us",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  validator: (String? value) {
                    String email = (value?.trim() ?? "");
                    if (EmailValidator.validate(email) == false) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter your fast name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(hintText: "Fast Name"),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter your last name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(hintText: "Last Name"),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (String? value) {
                    String phone = value?.trim() ?? '';
                    RegExp regExp = RegExp(r"^(?:\+?88|0088)?01[15-9]\d{8}$");
                    if (regExp.hasMatch(phone) == false) {
                      return 'Enter your valid phone';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _mobileTEController,
                  decoration: const InputDecoration(hintText: "Mobile"),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (String? value) {
                    if ((value!.isEmpty == true) || (value.length < 6)) {
                      return "Enter password";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  controller: _passwordTEController,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                const SizedBox(
                  height: 18,
                ),
                Visibility(
                  visible: _registrationInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: onTapSubmit,
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14),
                          children: [
                        const TextSpan(text: "Have an account ?"),
                        TextSpan(
                            text: "Singing",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = onTablogin)
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void onTapSubmit() {
    if (_formkey.currentState!.validate()) {
      _registerUser();
    }
  }
  //----------------------------registerUser----------------------------------------

  Future<void> _registerUser() async {
    _registrationInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text,
      "password": _passwordTEController.text
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );
    _registrationInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'User registered successfully!');
    } else {
      showSnackBarMessage(context, 'User registered Unsccessfull!');
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
  }

  void onTablogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _passwordTEController.dispose();
    _mobileTEController.dispose();

    super.dispose();
  }
}
