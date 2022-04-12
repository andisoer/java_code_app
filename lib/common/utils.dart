import 'package:intl/intl.dart';

String convertEpochToDate(int epochDate, String format) {
  var date = DateTime.fromMillisecondsSinceEpoch(epochDate * 1000);

  var dateFormat = DateFormat(format);

  var formattedDate = dateFormat.format(date);

  return formattedDate;
}