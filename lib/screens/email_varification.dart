import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/screens/pin_veripaication.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';

class EmailVarification extends StatefulWidget {
  const EmailVarification({super.key});

  @override
  State<EmailVarification> createState() => _EmailVarificationState();
}

class _EmailVarificationState extends State<EmailVarification> {
  final GlobalKey<FormState> _formkye = GlobalKey<FormState>();

  final TextEditingController _emailTEContolor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formkye,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                "Your Email Address",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "A 6 Digite verification pin will send to your email adderss",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 14),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  TextFormField(
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return "value is empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEContolor,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: onSubmit,
                  child: const Icon(Icons.arrow_circle_right_outlined)),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.black45),
                        children: [
                      const TextSpan(text: "Have No Account ? "),
                      TextSpan(
                          text: " Sing Up",
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = onTablogin),
                    ])),
              )
            ],
          ),
        ),
      )),
    );
  }

  void onSubmit() {
    String email = _emailTEContolor.text;
    _getOTPfromEmail(email);
  }

  Future<void> _getOTPfromEmail(String email) async {
    NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.recoverEmail(email));
    if (response.isSuccess) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVeripaication(
              remail: email,
            ),
          ));
    } else {}
  }

  // void onTap() {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const PinVeripaication(),
  //       ));
  // }

  void onTablogin() {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const RegestarScreen(),
    //     ));
  }
}
