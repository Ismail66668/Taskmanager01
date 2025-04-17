import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel_list.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/widgets/task_card.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

class CancleTaskScreen extends StatefulWidget {
  const CancleTaskScreen({super.key});

  @override
  State<CancleTaskScreen> createState() => _CancleTaskScreenState();
}

class _CancleTaskScreenState extends State<CancleTaskScreen> {
  bool _cancleModelListProgressIndcator = false;
  List<TaskModel> _cancleTasklist = [];

  @override
  void initState() {
    super.initState();
    _getAllCancleTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppbar(
        fromProfileScren: false,
      ),
      body: Visibility(
        visible: _cancleModelListProgressIndcator == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
            primary: false,
            itemBuilder: (context, index) {
              return TaskCared(
                taskModel: _cancleTasklist[index],
                status: "cancel",
                taskStatus: TaskStatus.cancle,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 2,
                ),
            itemCount: _cancleTasklist.length),
      ),
    );
  }

  // Future<void> _getAllNewTaskList() async {
  //   _getNewTasksInProgress = true;
  //   setState(() {});
  //   final NetworkResponse response =
  //       await NetworkClient.getRequest(url: Urls.newTaskListUrl);
  //   if (response.isSuccess) {
  //     TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
  //     _newTaskList = taskListModel.taskList;
  //   } else {}

  //   _getNewTasksInProgress = false;
  //   setState(() {});
  // }

  Future<void> _getAllCancleTask() async {
    _cancleModelListProgressIndcator = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.cancelledTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _cancleTasklist = taskListModel.taskList;
    }
    _cancleModelListProgressIndcator = false;
    setState(() {});
  }
}
