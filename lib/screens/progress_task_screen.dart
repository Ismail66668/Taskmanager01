import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel_list.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/widgets/task_card.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _progressTaskInProgress = false;
  List<TaskModel> _taskmodel = [];
  @override
  void initState() {
    super.initState();
    _getAllProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppbar(
        fromProfileScren: false,
      ),
      body: Visibility(
        visible: _progressTaskInProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: _taskmodel.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskStatus: TaskStatus.progress,
              taskModel: _taskmodel[index],
              refreshList: _getAllProgressTask,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 2,
          ),
        ),
      ),
    );
  }

  Future<void> _getAllProgressTask() async {
    _progressTaskInProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.progressTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taslistmodel = TaskListModel.fromJson(response.data!);
      _taskmodel = taslistmodel.taskList;
    }
    _progressTaskInProgress = false;
    setState(() {});
  }
}
