import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/date_Extension/date_Extension.dart';
import 'package:todo_app/dataBaseManager/model/todo_DM.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../providers/theme_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isLightTheme = themeProvider.themeMode == ThemeMode.light;
    final TextStyle bottomSheetTitleStyle = isLightTheme ? LightAppStyle.bottomSheetTitle : DarkAppStyle.bottomSheetTitle;
    final TextStyle hintStyle = isLightTheme ? LightAppStyle.hint : DarkAppStyle.hint;
    final TextStyle dateStyle = isLightTheme ? LightAppStyle.date : DarkAppStyle.date;
    final Color backgroundColor = isLightTheme ? ColorsManager.white : ColorsManager.darkBs;
    final Color buttonBackgroundColor = ColorsManager.blue;
    final Color buttonTextColor = isLightTheme ? ColorsManager.white : ColorsManager.black;
    final TextStyle inputTextStyle = TextStyle(color: isLightTheme ? ColorsManager.black : ColorsManager.white,);

    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * 0.4,
      color: backgroundColor,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new task',
              textAlign: TextAlign.center,
              style: bottomSheetTitleStyle,
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Please enter a task title';
                }
                return null;
              },
              controller: titleController,
              style: inputTextStyle,
              decoration: InputDecoration(
                hintText: 'Enter your task title',
                hintStyle: hintStyle,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorsManager.blue),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: isLightTheme ? Colors.black : Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Please enter a task description';
                }
                if (input.length < 6) {
                  return 'Description should be at least 6 characters';
                }
                return null;
              },
              controller: descriptionController,
              style: inputTextStyle,
              decoration: InputDecoration(
                hintText: 'Enter your task description',
                hintStyle: hintStyle,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorsManager.blue),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: isLightTheme ? Colors.black : Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('Select date', style: dateStyle),
            InkWell(
              onTap: () {
                showTaskDate(context);
              },
              child: Text(
                selectedDate.toFormattedDate,
                style: hintStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                addTaskToFireStore();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonBackgroundColor,
              ),
              child: Text(
                'Add task',
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTaskDate(BuildContext context) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final bool isLightTheme = themeProvider.themeMode == ThemeMode.light;

    final datePickerTheme = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(
        primary: ColorsManager.blue,
        onPrimary: ColorsManager.white,
        onSurface: ColorsManager.black,
      ),
      dialogBackgroundColor: ColorsManager.white,
    );

    final datePickerThemeDark = Theme.of(context).copyWith(
      colorScheme: ColorScheme.dark(
        primary: ColorsManager.blue,
        onPrimary: ColorsManager.black,
        surface: ColorsManager.blackAccent,
        onSurface: ColorsManager.white,
      ),
      dialogBackgroundColor: ColorsManager.blackAccent,
    );

    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: isLightTheme ? datePickerTheme : datePickerThemeDark,
          child: child!,
        );
      },
    ) ?? selectedDate;

    setState(() {});
  }

  void addTaskToFireStore() {
    if (formKey.currentState!.validate() == false) return;
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc();
    TodoDM todo = TodoDM(
      id: documentReference.id,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
      isDone: false,
    );
    documentReference.set(todo.toFireStore()).then((value) {}).onError(
          (error, stackTrace) {},
    ).timeout(
      const Duration(milliseconds: 500),
      onTimeout: () {
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}
