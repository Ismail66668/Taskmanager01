// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel.dart';

enum TaskStatus { sNew, progress, complete, cancle }

enum TaskStatusText { sNew, progress, complete, cancle }

// ignore: must_be_immutable
class TaskCared extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables, use_super_parameters
  TaskCared({
    Key? key,
    required this.taskStatus,
    required this.status,
    required this.taskModel,
  }) : super(key: key);

  final TaskStatus taskStatus;
  final String status;
  final TaskModel taskModel;

  @override
  State<TaskCared> createState() => _TaskCaredState();
}

class _TaskCaredState extends State<TaskCared> {
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
            Text(
              "widget.taskModel.titel",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text("widget.taskModel.discription",
                style: const TextStyle(fontSize: 12)),
            Text("widget.taskModel.createDate",
                style: const TextStyle(fontSize: 12)),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.status,
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
    switch (widget.taskStatus) {
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
