// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/core/utils/app_styles.dart';
// import 'package:todo_app/core/utils/date_Extension/date_Extension.dart';
// import 'package:todo_app/dataBaseManager/model/todo_DM.dart';
// import '../../../../core/utils/colors_manager.dart';
// import '../../../../providers/theme_provider.dart';
//
// class EditTaskBottomSheet extends StatefulWidget {
//   final TodoDM todo;
//
//   EditTaskBottomSheet({super.key, required this.todo});
//
//   static Future<TodoDM?> show(BuildContext context, TodoDM todo) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) => Padding(
//         padding: MediaQuery.of(context).viewInsets,
//         child: EditTaskBottomSheet(todo: todo),
//       ),
//     );
//   }
//
//   @override
//   State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
// }
//
// class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
//   DateTime selectedDate = DateTime.now();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDate = widget.todo.dateTime;
//     titleController.text = widget.todo.title;
//     descriptionController.text = widget.todo.description;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final bool isLightTheme = themeProvider.themeMode == ThemeMode.light;
//
//     final TextStyle bottomSheetTitleStyle = isLightTheme ? LightAppStyle.bottomSheetTitle : DarkAppStyle.bottomSheetTitle;
//     final TextStyle hintStyle = isLightTheme ? LightAppStyle.hint : DarkAppStyle.hint;
//     final TextStyle dateStyle = isLightTheme ? LightAppStyle.date : DarkAppStyle.date;
//
//     final Color backgroundColor = isLightTheme ? ColorsManager.white : ColorsManager.darkBs;
//
//     final Color buttonBackgroundColor = ColorsManager.blue;
//     final Color buttonTextColor = isLightTheme ? ColorsManager.white : ColorsManager.black;
//
//     return Container(
//       padding: EdgeInsets.all(12),
//       height: MediaQuery.of(context).size.height * 0.7,
//       color: backgroundColor,
//       child: Form(
//         key: formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Edit Task',
//               textAlign: TextAlign.center,
//               style: bottomSheetTitleStyle,
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               validator: (input) {
//                 if (input == null || input.trim().isEmpty) {
//                   return 'Please enter a task title';
//                 }
//                 return null;
//               },
//               controller: titleController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your task title',
//                 hintStyle: hintStyle,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               validator: (input) {
//                 if (input == null || input.trim().isEmpty) {
//                   return 'Please enter a task description';
//                 }
//                 if (input.length < 6) {
//                   return 'Description should be at least 6 characters';
//                 }
//                 return null;
//               },
//               controller: descriptionController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your task description',
//                 hintStyle: hintStyle,
//               ),
//             ),
//             const SizedBox(height: 40),
//             Text('Select date', style: dateStyle),
//             InkWell(
//               onTap: () {
//                 showTaskDate(context);
//               },
//               child: Text(
//                 selectedDate.toFormattedDate,
//                 style: hintStyle,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 if (formKey.currentState!.validate()) {
//                   updateTaskInFireStore();
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                 backgroundColor: buttonBackgroundColor,
//                 textStyle: TextStyle(color: buttonTextColor),
//               ),
//               child: Text(
//                 'Save Changes',
//                 style: TextStyle(color: buttonTextColor),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void showTaskDate(BuildContext context) async {
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     final bool isLightTheme = themeProvider.themeMode == ThemeMode.light;
//
//     final datePickerTheme = Theme.of(context).copyWith(
//       colorScheme: ColorScheme.light(
//         primary: ColorsManager.blue,
//         onPrimary: ColorsManager.white,
//         onSurface: ColorsManager.black,
//       ),
//       dialogBackgroundColor: Colors.white,
//     );
//
//     final datePickerThemeDark = Theme.of(context).copyWith(
//       colorScheme: ColorScheme.dark(
//         primary: ColorsManager.blue,
//         onPrimary: ColorsManager.black,
//         surface: Color(0xFF1C1C1C),
//         onSurface: ColorsManager.white,
//       ),
//       dialogBackgroundColor: Color(0xFF1C1C1C),
//     );
//
//     selectedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//       builder: (context, child) {
//         return Theme(
//           data: isLightTheme ? datePickerTheme : datePickerThemeDark,
//           child: child!,
//         );
//       },
//     ) ?? selectedDate;
//
//     setState(() {});
//   }
//
//   void updateTaskInFireStore() {
//     CollectionReference collectionReference =
//     FirebaseFirestore.instance.collection(TodoDM.collectionName);
//     DocumentReference documentReference = collectionReference.doc(widget.todo.id);
//
//     TodoDM updatedTodo = widget.todo.copyWith(
//       title: titleController.text,
//       description: descriptionController.text,
//       dateTime: selectedDate,
//     );
//
//     documentReference.update(updatedTodo.toFireStore()).then((value) {
//       if (context.mounted) {
//         Navigator.of(context).pop(updatedTodo);
//       }
//     }).catchError((error) {
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/date_Extension/date_Extension.dart';
import 'package:todo_app/dataBaseManager/model/todo_DM.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../providers/theme_provider.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final TodoDM todo;

  EditTaskBottomSheet({super.key, required this.todo});

  static Future<TodoDM?> show(BuildContext context, TodoDM todo) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: EditTaskBottomSheet(todo: todo),
      ),
    );
  }

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.todo.dateTime;
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
  }

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

    final TextStyle inputTextStyle = TextStyle(
      color: isLightTheme ? Colors.black : Colors.white, // Input text color based on theme
    );

    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * 0.7,
      color: backgroundColor,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit Task',
              textAlign: TextAlign.center,
              style: bottomSheetTitleStyle,
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 40),
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
                if (formKey.currentState!.validate()) {
                  updateTaskInFireStore();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: buttonBackgroundColor,
              ),
              child: Text(
                'Save Changes',
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
      dialogBackgroundColor: Colors.white,
    );

    final datePickerThemeDark = Theme.of(context).copyWith(
      colorScheme: ColorScheme.dark(
        primary: ColorsManager.blue,
        onPrimary: ColorsManager.black,
        surface: Color(0xFF1C1C1C),
        onSurface: ColorsManager.white,
      ),
      dialogBackgroundColor: Color(0xFF1C1C1C),
    );

    selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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

  void updateTaskInFireStore() {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc(widget.todo.id);

    TodoDM updatedTodo = widget.todo.copyWith(
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
    );

    documentReference.update(updatedTodo.toFireStore()).then((value) {
      if (context.mounted) {
        Navigator.of(context).pop(updatedTodo);
      }
    }).catchError((error) {
    });
  }
}
