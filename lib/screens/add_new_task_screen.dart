import 'package:flutter/material.dart';
import 'package:taskmenager_app/data/models/taskmanagercountmodel_list.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel.dart';
import 'package:taskmenager_app/data/models/taskmodel/taskmodel_list.dart';
import 'package:taskmenager_app/data/urls/urls.dart';
import 'package:taskmenager_app/screens/add_task.dart';
import 'package:taskmenager_app/widgets/tm_appbar.dart';

import '../data/models/taskstatuscountmodel.dart';
import '../data/service/netwark_client.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final bool _statusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  bool _getNewTasksInProgress = false;
  List<TaskModel> _newTaskList = [];
  @override
  void initState() {
    super.initState();
    _getAlltaskStatusCount();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppbar(
        fromProfileScren: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: _statusCountInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: SummarySection()),
          Expanded(
            child: Visibility(
              visible: _getNewTasksInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.separated(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskStatus: TaskStatus.sNew,
                      taskModel: _newTaskList[index],
                      refreshList: _getAllNewTaskList,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 2)),
            ),
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
  Padding SummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _taskStatusCountList.length,
          itemBuilder: (context, index) {
            return SummaryCard(
                title: _taskStatusCountList[index].status,
                count: _taskStatusCountList[index].count);
          },
        ),
      ),
    );
  }

  Future<void> _getAlltaskStatusCount() async {
    _statusCountInProgress == true;
    setState(() {});
    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);

    if (response.isSuccess) {
      TaskStatusCountListModel taskmanagercountmodel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskmanagercountmodel.statusCountList;
    } else {}
    _statusCountInProgress == false;
    setState(() {});
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTasksInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.newTaskListUrl);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
      setState(() {});
    } else {}

    _getNewTasksInProgress = false;
    setState(() {});
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
}
