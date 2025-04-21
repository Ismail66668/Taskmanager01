// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:taskmenager_app/data/models/taskmodel/taskmodel.dart';
// import 'package:taskmenager_app/data/service/netwark_client.dart';
// import 'package:taskmenager_app/data/urls/urls.dart';

// enum TaskStatus { sNew, progress, complete, cancle }

// enum TaskStatusText { sNew, progress, complete, cancle }

// // ignore: must_be_immutable
// class TaskCared extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables, use_super_parameters
//   TaskCared({
//     Key? key,
//     required this.taskStatus,
//     required this.status,
//     required this.taskModel,
//   }) : super(key: key);

//   final TaskStatus taskStatus;
//   final String status;
//   final TaskModel taskModel;

//   @override
//   State<TaskCared> createState() => _TaskCaredState();
// }

// class _TaskCaredState extends State<TaskCared> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.taskModel.titel,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             Text(widget.taskModel.discription,
//                 style: const TextStyle(fontSize: 12)),
//             Text("", style: const TextStyle(fontSize: 12)),
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               children: [
//                 Chip(
//                   label: Text(
//                     widget.taskModel.status,
//                     style: const TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40)),
//                   backgroundColor: _getStatusColors(),
//                   side: BorderSide.none,
//                 ),
//                 const Spacer(),
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.delete,
//                       color: _getStatusColors(),
//                     )),
//                 IconButton(
//                     onPressed: _showUpdateStatusDialog,
//                     icon: const Icon(Icons.edit)),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _showUpdateStatusDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Update status"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                   onTap: () {
//                     if (isSelected("New")) {
//                       _changeTaskstatus("New");
//                     }
//                   },
//                   title: const Text("New"),
//                   trailing: isSelected("New") ? const Icon(Icons.done) : null),
//               ListTile(
//                   onTap: () {
//                     if (isSelected("Progress")) {
//                       _changeTaskstatus("Progress");
//                     }
//                   },
//                   title: const Text("Progress"),
//                   trailing:
//                       isSelected("Progress") ? const Icon(Icons.done) : null),
//               ListTile(
//                   onTap: () {
//                     if (isSelected("Completed")) {
//                       _changeTaskstatus("Completed");
//                     }
//                   },
//                   title: const Text("Completed"),
//                   trailing:
//                       isSelected("Completed") ? const Icon(Icons.done) : null),
//               ListTile(
//                   onTap: () {
//                     if (isSelected("Cancelled")) {
//                       _changeTaskstatus("Cancelled");
//                     }
//                   },
//                   title: const Text("Cancelled"),
//                   trailing:
//                       isSelected("Cancelled") ? const Icon(Icons.done) : null)
//             ],
//           ),
//         );
//       },
//     );
//   }

//   bool isSelected(String status) {
//     return widget.taskModel.status == status;
//   }

//   Future<void> _changeTaskstatus(String status) async {
//     NetworkResponse response = await NetworkClient.getRequest(
//         url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
//     if (response.isSuccess) {
//     } else {}
//   }

//   void _popDialog() {
//     Navigator.pop(context);
//   }

//   Color _getStatusColors() {
//     late Color color;
//     switch (widget.taskStatus) {
//       // ignore: constant_pattern_never_matches_value_type
//       case TaskStatus.sNew:
//         color = Colors.blue;
//       // ignore: constant_pattern_never_matches_value_type
//       case TaskStatus.progress:
//         color = Colors.purple;
//       // ignore: constant_pattern_never_matches_value_type
//       case TaskStatus.complete:
//         color = Colors.deepOrange;
//       // ignore: constant_pattern_never_matches_value_type
//       case TaskStatus.cancle:
//         color = Colors.red;
//     }
//     return color;
//   }
// }
import 'package:flutter/material.dart';

import 'package:taskmenager_app/data/models/taskmodel/taskmodel.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';

enum TaskStatus { sNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.taskModel,
    required this.refreshList,
  });

  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(widget.taskModel.description,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            Text('Date: ${widget.taskModel.createdDate},',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: _getStatusChipColor(),
                  side: BorderSide.none,
                ),
                const Spacer(),
                Visibility(
                  visible: _inProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _deleteTask,
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                          onPressed: _showUpdateStatusDialog,
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor() {
    late Color color;
    switch (widget.taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
      case TaskStatus.progress:
        color = Colors.purple;
      case TaskStatus.completed:
        color = Colors.green;
      case TaskStatus.cancelled:
        color = Colors.red;
    }
    return color;
  }

  void _showUpdateStatusDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('New')) return;
                    _changeTaskStatus('New');
                  },
                  title: const Text('New'),
                  trailing: isSelected('New') ? const Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('Progress')) return;
                    _changeTaskStatus('Progress');
                  },
                  title: const Text('Progress'),
                  trailing:
                      isSelected('Progress') ? const Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('Completed')) return;
                    _changeTaskStatus('Completed');
                  },
                  title: const Text('Completed'),
                  trailing:
                      isSelected('Completed') ? const Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _popDialog();
                    if (isSelected('Cancelled')) return;
                    _changeTaskStatus('Cancelled');
                  },
                  title: const Text('Cancelled'),
                  trailing:
                      isSelected('Cancelled') ? const Icon(Icons.done) : null,
                ),
              ],
            ),
          );
        });
  }

  void _popDialog() {
    Navigator.pop(context);
  }

  bool isSelected(String status) => widget.taskModel.status == status;

  Future<void> _changeTaskStatus(String status) async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
        url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));

    _inProgress = false;
    if (response.isSuccess) {
      widget.refreshList();
    } else {
      setState(() {});
      // showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _deleteTask() async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
        url: Urls.deleteTaskUrl(widget.taskModel.id));

    _inProgress = false;
    if (response.isSuccess) {
      widget.refreshList();
    } else {
      setState(() {});
      // showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
