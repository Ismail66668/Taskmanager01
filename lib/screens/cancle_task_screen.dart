import 'package:flutter/material.dart';
import 'package:taskmenager_app/widgets/task_card.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

class CancleTaskScreen extends StatefulWidget {
  const CancleTaskScreen({super.key});

  @override
  State<CancleTaskScreen> createState() => _CancleTaskScreenState();
}

class _CancleTaskScreenState extends State<CancleTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(
        fromProfileScren: false,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return const TaskCare(
              status: "cancel",
              taskStatus: TaskStatus.cancle,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
          itemCount: 4),
    );
  }
}
