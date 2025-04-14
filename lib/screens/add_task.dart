import 'package:flutter/material.dart';
import 'package:taskmenager_app/widgets/screenbackground.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Subject",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: "Discription",
                  )),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: _submitButton,
                  child: const Icon(Icons.arrow_circle_right_outlined)),
            ],
          ),
        ),
      ),
    );
  }

  void _submitButton() {}
}
