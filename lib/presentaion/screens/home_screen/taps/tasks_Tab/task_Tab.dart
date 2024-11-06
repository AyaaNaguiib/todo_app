import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/date_Extension/date_Extension.dart';
import 'package:todo_app/presentaion/screens/home_screen/taps/tasks_Tab/task_item/todo_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: ColorsManager.blue, height: 100.h,),
        buildCalender(),
      ],
    );
  }

  Widget buildCalender(){
    return EasyInfiniteDateTimeLine(

      firstDate: DateTime.now().subtract(Duration(days: 365)),
      focusDate: calenderSelectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateChange: (selectedDate) {
        // setState(() {
        //   _focusDate = selectedDate;
        // });
      },
      itemBuilder: (context,date, isSelected,onTab){
        return InkWell(
          onTap: (){
            calenderSelectedDate = date;
            setState(() {});
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
                Text(date.getDayName,style: isSelected ? LightAppStyle.calenderSelectedDate: LightAppStyle.calenderUnSelectedDate,),
                Text('${date.day}',style: isSelected ? LightAppStyle.calenderSelectedDate: LightAppStyle.calenderUnSelectedDate,),
              ],
            ),
          ),
        );
      },
    );
  }
}
