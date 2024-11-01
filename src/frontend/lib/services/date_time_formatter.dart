import 'package:intl/intl.dart';

String time_formatter(DateTime dateTime) {
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}