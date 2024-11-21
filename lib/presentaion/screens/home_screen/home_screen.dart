import 'package:flutter/material.dart';
import 'package:todo_app/presentaion/screens/home_screen/app_task_BS/app_task_bottomsheet.dart';
import 'package:todo_app/presentaion/screens/home_screen/taps/settings_tab/settings_tab.dart';
import 'package:todo_app/presentaion/screens/home_screen/taps/tasks_Tab/task_Tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  int currentIndex = 0;
  List<Widget>tabs = [];



  @override
  void initState() {
    super.initState();
    tabs = [
      TasksTab(key: tasksTabKey,),
      SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar: buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  Widget buildBottomNavBar() => ClipRRect(
    clipBehavior: Clip.antiAlias,
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(15),
      topLeft: Radius.circular(15),
    ),
    child: BottomAppBar(
      notchMargin: 6,
      shape: const CircularNotchedRectangle(),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (tappedIndex) {
          setState(() {
            currentIndex = tappedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list,),
              label: 'Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings'
          ),
        ],
      ),
    ),
  );

  Widget buildFab() => FloatingActionButton(
    onPressed: () async {
      await AddTaskBottomSheet.show(context);
      tasksTabKey.currentState?.getTodoFromFireStore();
    },
    child: const Icon(Icons.add,),
  );
}
