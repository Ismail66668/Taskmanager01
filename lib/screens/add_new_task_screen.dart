import 'package:flutter/material.dart';
import 'package:taskmenager_app/screens/add_task.dart';
import 'package:taskmenager_app/widgets/task_card.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

import '../widgets/tm_summary.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppbar(
        fromProfileScren: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummarySection(),
          Expanded(
            child: ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const TaskCare(
                    status: "new",
                    taskStatus: TaskStatus.sNew,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 2)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addtask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addtask() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddTask(),
        ));
  }

  // ignore: non_constant_identifier_names
  Row SummarySection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        sumaryCard(
          count: 10,
          title: "New",
        ),
        sumaryCard(
          count: 8,
          title: "Progress",
        ),
        sumaryCard(
          count: 15,
          title: "Update",
        ),
        sumaryCard(
          count: 5,
          title: "Cancale",
        ),
      ],
    );
  }
}
