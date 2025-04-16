import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';
import 'package:taskmenager_app/widgets/showsnackbarmassag.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _fromKye = GlobalKey();
  bool _addNewTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _fromKye,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Add Task",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _titleTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Subject",
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _descriptionTEController,
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: "Discription",
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Visibility(
                  visible: _addNewTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: _submitButton,
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitButton() {
    if (_fromKye.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };

    final NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.createTaskUrl,
      body: requestBody,
    );

    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New task added!');
    } else {
      showSnackBarMessage(context, "Un Successs------------ ");
    }
  }

  // Future<void> _addNewTask() async {
  //   _addNewTaskInProgress = true;
  //   setState(() {});
  //   Map<String, dynamic> requestBody = {
  //     "title": _titleTEController.text.trim(),
  //     "description": _descriptionTEController.text.trim(),
  //     "status": "New"
  //   };
  //   final NetworkResponse response =
  //       await NetworkClient.postRequest(url: Urls.loginUrl, body: requestBody);
  //   _addNewTaskInProgress = false;
  //   setState(() {});
  //   if (response.isSuccess) {
  //     _cleare();
  //     showSnackBarMessage(context, 'New TaskAdd!');
  //   } else {
  //     showSnackBarMessage(context, "UnSeccess");
  //   }
  // }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
