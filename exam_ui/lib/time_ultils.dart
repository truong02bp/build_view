String formatDate({required DateTime time}) {
  time = time.toLocal();
  DateTime now = DateTime.now().toLocal();
  String year = time.year.toString();
  String hour = time.hour.toString();
  String minute = time.minute.toString();
  String month = time.month.toString();
  String day = time.day.toString();
  if (time.hour <= 9)
    hour = "0" + hour;
  if (time.minute <= 9)
    minute = "0" + minute;
  if (time.month <= 9)
    month = "0" + month;
  if (time.day <= 9)
    day = "0" + day;

  if (now.day == time.day)
    return "$hour:$minute";
  if (now.year == time.year)
    return "$year-$day-$month : $hour:$minute";
  return time.toString();
}