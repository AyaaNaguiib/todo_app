import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/colors_manager.dart';
import '../../../../../../dataBaseManager/model/todo_DM.dart';
import '../../../../../../providers/theme_provider.dart';
import '../../../../edit_task_BS/edit task screen.dart';

class TodoItem extends StatelessWidget {
  TodoItem({super.key, required this.todo, required this.onDeletedTask, required this.onUpdatedTask});

  final TodoDM todo;
  final Function onDeletedTask;
  final Function onUpdatedTask;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final todoTitleStyle = isDarkMode ? DarkAppStyle.todoTitle : LightAppStyle.todoTitle;
    final todoDescriptionStyle = isDarkMode ? DarkAppStyle.todoDiscription : LightAppStyle.todoDiscription;
    final containerColor = isDarkMode ? ColorsManager.darkBs : ColorsManager.white;
    final checkIconColor = isDarkMode ? ColorsManager.white : ColorsManager.white;

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.6,
          motion: BehindMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              onPressed: (context) {
                deleteTodoFromFireStore(todo);
                onDeletedTask();
              },
              backgroundColor: ColorsManager.red,
              foregroundColor: ColorsManager.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) async {
                final updatedTodo = await EditTaskBottomSheet.show(context, todo);
                if (updatedTodo != null) {
                  onUpdatedTask(updatedTodo);
                }
              },
              backgroundColor: ColorsManager.blue,
              foregroundColor: ColorsManager.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color:  Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(todo.title, style: todoTitleStyle),
                  const SizedBox(height: 4),
                  Text(todo.description, style: todoDescriptionStyle),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.check, color: checkIconColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTodoFromFireStore(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.delete();
  }

}

