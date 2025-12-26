import 'package:intl/intl.dart';

String formatDate(String date) {
  try {
    final dt = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(dt);
  } catch (_) {
    return date;
  }
}
