import 'package:intl/intl.dart';

class Formatters {
  /// this function will format the given date and time
  /// if the date time is null it will return null
  /// otherwise it will return date time in "Apr-23 20:15" format
  static String? formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    DateTime local = dateTime.toLocal();
    final formattedDateTime = DateFormat("MMM-dd hh:mm").format(local);
    return formattedDateTime;
  }
}
