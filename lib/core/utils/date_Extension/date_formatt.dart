import 'package:intl/intl.dart';

String formatDate(DateTime date){
  DateFormat formatter = DateFormat('dd / MM/ YYYY');
  return formatter.format(date);
}