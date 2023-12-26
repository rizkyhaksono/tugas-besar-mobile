import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date != null) {
    return DateFormat('MMMM d, y').format(date);
  }
  return 'No Release Date';
}
