import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/date_Extension/date_Extension.dart';
import 'package:todo_app/dataBaseManager/model/todo_DM.dart';
import 'package:todo_app/presentaion/screens/home_screen/taps/tasks_Tab/task_item/todo_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todoList = [];

  @override
  void initState() {
    super.initState();
    getTodoFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(color: ColorsManager.blue, height: 100.h),
            buildCalender(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) => TodoItem(
              todo: todoList[index],
              onDeletedTask: () {
                getTodoFromFireStore();
              },
              onUpdatedTask: () {
                getTodoFromFireStore();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCalender() {
    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      focusDate: calenderSelectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateChange: (selectedDate) {},
      itemBuilder: (context, date, isSelected, onTab) {
        return InkWell(
          onTap: () {
            setState(() {
              calenderSelectedDate = date;
              getTodoFromFireStore();
            });
          },
          child: Card(
            elevation: 8,
            color: ColorsManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.getDayName,
                  style: isSelected
                      ? LightAppStyle.calenderSelectedDate
                      : LightAppStyle.calenderUnSelectedDate,
                ),
                Text(
                  '${date.day}',
                  style: isSelected
                      ? LightAppStyle.calenderSelectedDate
                      : LightAppStyle.calenderUnSelectedDate,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getTodoFromFireStore() async {
    CollectionReference todoCollection =
    FirebaseFirestore.instance.collection(TodoDM.collectionName);
    QuerySnapshot collectionSnapShot = await todoCollection.get();
    List<QueryDocumentSnapshot> documentSnapShot = collectionSnapShot.docs;
    todoList = documentSnapShot.map((docSnapShot) {
      Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
      TodoDM todo = TodoDM.fromFireStore(json);
      return todo;
    }).toList();
    todoList = todoList
        .where((todo) =>
    todo.dateTime.day == calenderSelectedDate.day &&
        todo.dateTime.month == calenderSelectedDate.month &&
        todo.dateTime.year == calenderSelectedDate.year)
        .toList();
    setState(() {});
  }
}
