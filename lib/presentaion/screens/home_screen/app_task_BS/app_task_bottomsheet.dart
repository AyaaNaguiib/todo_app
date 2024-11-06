import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/date_Extension/date_Extension.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static void show(context){
    showModalBottomSheet(context: context, builder: (context) => AddTaskBottomSheet());
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height*0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add new task', textAlign: TextAlign.center, style: LightAppStyle.bottomSheetTitle,),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'enter your task title',
              hintStyle: LightAppStyle.hint,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'enter your task description',
                hintStyle: LightAppStyle.hint,
            ),
          ),
          const SizedBox(height: 8),
          Text('Select date', style: LightAppStyle.date,),
          InkWell(
            onTap: (){
              showTaskDate(context);
            },
              child: Text(
                 selectedDate.toFormattedDate,
                style: LightAppStyle.hint,textAlign: TextAlign.center,)),
          const Spacer(),
          ElevatedButton(onPressed: (){},
              child: const Text('Add task'))
        ],
      ),
    );
  }

  void showTaskDate(context) async{
    selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    )?? selectedDate;

    setState(() {});
  }
}
