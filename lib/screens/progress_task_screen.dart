import 'package:flutter/material.dart';
import 'package:taskmenager_app/widgets/task_card.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(
        fromProfileScren: false,
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const TaskCare(
            status: "progress",
            taskStatus: TaskStatus.progress,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 2,
        ),
      ),
    );
  }
}
