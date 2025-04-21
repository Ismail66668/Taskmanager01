import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel_list.dart';
import 'package:taskmenager_app/data/service/netwark_client.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

import '../widgets/task_card.dart';

// ignore: must_be_immutable
class CompletTaskScreen extends StatefulWidget {
  const CompletTaskScreen({
    super.key,
  });

  @override
  State<CompletTaskScreen> createState() => _CompletTaskScreenState();
}

class _CompletTaskScreenState extends State<CompletTaskScreen> {
  bool _complerTaskInProgress = false;
  List<TaskModel> _completModellist = [];
  @override
  void initState() {
    super.initState();
    _getCompletAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppbar(
        fromProfileScren: false,
      ),
      body: Visibility(
        visible: _complerTaskInProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: _completModellist.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskStatus: TaskStatus.progress,
              taskModel: _completModellist[index],
              refreshList: _getCompletAllTask,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 2,
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletAllTask() async {
    _complerTaskInProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.completedTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _completModellist = taskListModel.taskList;
    }
    _complerTaskInProgress = false;
    setState(() {});
  }
}
