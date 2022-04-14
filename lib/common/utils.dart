import 'package:intl/intl.dart';

String convertEpochToDate(int epochDate, String format) {
  var date = DateTime.fromMillisecondsSinceEpoch(epochDate * 1000);

  var dateFormat = DateFormat(format);

  var formattedDate = dateFormat.format(date);

  return formattedDate;
}

String convertDate(String date, String format) {

  var dateFormat = DateFormat('yyyy-MM-dd');

  var formattedDate = dateFormat.parse(date);

  var outputFormat = DateFormat(format);
  var outputDate = outputFormat.format(formattedDate);

  return outputDate;
}