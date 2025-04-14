import 'package:flutter/material.dart';
import 'package:taskmenager_app/screens/add_new_task_screen.dart';
import 'package:taskmenager_app/screens/cancle_task_screen.dart';
import 'package:taskmenager_app/screens/complet_task_screen.dart';
import 'package:taskmenager_app/screens/progress_task_screen.dart';

class MainBottomNevBar extends StatefulWidget {
  const MainBottomNevBar({super.key});

  @override
  State<MainBottomNevBar> createState() => _MainBottomNevBarState();
}

class _MainBottomNevBarState extends State<MainBottomNevBar> {
  int _index = 0;
  List<Widget> pages = [
    const AddNewTaskScreen(),
    const ProgressTaskScreen(),
    const CompletTaskScreen(),
    const CancleTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) {
            setState(() {
              _index = value;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.new_label), label: "New"),
            NavigationDestination(
                icon: Icon(Icons.ac_unit_sharp), label: "Pogress"),
            NavigationDestination(icon: Icon(Icons.done), label: "Complet"),
            NavigationDestination(icon: Icon(Icons.cancel), label: "Cancle"),
          ]),
    );
  }
}
