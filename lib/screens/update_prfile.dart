import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/models/usermodel.dart';
import 'package:taskmenager_app/screens/controller/authcontroller.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../data/service/netwark_client.dart';
import '../data/urls/urls.dart';
import '../widgets/showsnackbarmassag.dart';

class UpdatePrfile extends StatefulWidget {
  const UpdatePrfile({super.key});

  @override
  State<UpdatePrfile> createState() => _UpdatePrfileState();
}

class _UpdatePrfileState extends State<UpdatePrfile> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEControllers = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _updateProfileInProgress = false;

  final ImagePicker _imagPicker = ImagePicker();
  XFile? _pickImage;
  @override
  void initState() {
    super.initState();
    UserModel userModel = Authcontroller.userModel!;
    _emailTEController.text = userModel.email;
    _firstNameTEControllers.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppbar(
        fromProfileScren: true,
      ),
      body: Screenbackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                "Update Profile",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        _pickImage?.name ?? "Chooch Photo",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onTapPhotoPic();
                    },
                    child: Container(
                      height: 48,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.5)),
                      child: const Center(
                        child: Text(
                          "Photo",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter your email";
                  }
                  return null;
                },
                enabled: false,
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter your fast name";
                  }
                  return null;
                },
                controller: _firstNameTEControllers,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "Fast Name"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter your lastName";
                  }
                  return null;
                },
                controller: _lastNameTEController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "Last Name"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter your Phone";
                  }
                  return null;
                },
                controller: _mobileTEController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "Phone"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _passwordTEController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 24,
              ),
              Visibility(
                visible: _updateProfileInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      _onUpdateProfileSubmit();
                    },
                    child: const Icon(Icons.arrow_circle_right_outlined)),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _onTapPhotoPic() async {
    XFile? image = await _imagPicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _pickImage = image;
      setState(() {});
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEControllers.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text,
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody["password"] = _passwordTEController.text;
    }
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );
    _updateProfileInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _passwordTEController.clear();

      showSnackBarMessage(context, 'Update Profile successfully!');
    } else {
      showSnackBarMessage(context, 'Update Profile Unsccessfull!');
    }
  }

  void _onUpdateProfileSubmit() {
    if (_formkey.currentState!.validate()) {
      _updateProfile();
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEControllers.dispose();
    _lastNameTEController.dispose();
    _passwordTEController.dispose();
    _mobileTEController.dispose();

    super.dispose();
  }
}
