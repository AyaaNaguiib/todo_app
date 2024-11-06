import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/presentaion/screens/home_screen/app_task_BS/app_task_bottomsheet.dart';
import 'package:todo_app/presentaion/screens/home_screen/taps/settings_tab/settings_tab.dart';
import 'package:todo_app/presentaion/screens/home_screen/taps/tasks_Tab/task_Tab.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget>tabs = [
    TasksTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar:buildBottomNavBar(),

      body:  tabs[currentIndex],
    );
  }



 Widget buildBottomNavBar() => ClipRRect(
   clipBehavior: Clip.antiAlias,
   borderRadius: const BorderRadius.only(
     topRight: Radius.circular(15),
     topLeft: Radius.circular(15),
   ),
   child: BottomAppBar(
     notchMargin: 8,
     child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (tappedIndex){
          currentIndex = tappedIndex;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list),label:'Tasks' ),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: 'Settings'),
        ],
      ),
   ),
 );

 Widget buildFab() => FloatingActionButton(
    onPressed: (){
      AddTaskBottomSheet.show(context);
    },
    child: Icon(Icons.add),
  );
}
