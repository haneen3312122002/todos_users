import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) {
    return DateFormat('yyyy-MM-dd – HH:mm').format(date);
  }
}