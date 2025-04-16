import 'package:flutter/material.dart';
import 'package:taskmenager_app/widgets/task_card.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

// ignore: must_be_immutable
class CompletTaskScreen extends StatefulWidget {
  const CompletTaskScreen({
    super.key,
  });

  @override
  State<CompletTaskScreen> createState() => _CompletTaskScreenState();
}

class _CompletTaskScreenState extends State<CompletTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppbar(
        fromProfileScren: false,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            // return const TaskCared(
            //   status: "complet",
            //   taskStatus: TaskStatus.complete,
            // );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
          itemCount: 5),
    );
  }
}
