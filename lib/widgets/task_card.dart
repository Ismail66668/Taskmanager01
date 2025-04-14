// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum TaskStatus { sNew, progress, complete, cancle }

enum TaskStatusText { sNew, progress, complete, cancle }

// ignore: must_be_immutable
class TaskCare extends StatelessWidget {
  const TaskCare({Key? key, required this.taskStatus, required this.status})
      : super(key: key);

  final TaskStatus taskStatus;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Titel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Text("Discription", style: TextStyle(fontSize: 12)),
            const Text("Date : 12/10/25", style: TextStyle(fontSize: 12)),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  backgroundColor: _getStatusColors(),
                  side: BorderSide.none,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: _getStatusColors(),
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusColors() {
    late Color color;
    switch (taskStatus) {
      // ignore: constant_pattern_never_matches_value_type
      case TaskStatus.sNew:
        color = Colors.blue;
      // ignore: constant_pattern_never_matches_value_type
      case TaskStatus.progress:
        color = Colors.purple;
      // ignore: constant_pattern_never_matches_value_type
      case TaskStatus.complete:
        color = Colors.deepOrange;
      // ignore: constant_pattern_never_matches_value_type
      case TaskStatus.cancle:
        color = Colors.red;
    }
    return color;
  }
}
