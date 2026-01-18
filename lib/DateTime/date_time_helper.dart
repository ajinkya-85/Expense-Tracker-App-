// convert datetime obj. into a string yyyymmdd

String converDateTimeToString(DateTime datetime) {
  //year in the format format yyyy
  String year = datetime.year.toString();
  //month in the format mm
  String month = datetime.month.toString();
  if (month.length == 1) {
    month = "0" + month;
  }
  //day in the format of dd
  String day = datetime.day.toString();
  if (day.length == 1) {
    day = "0" + day;
  }
  // final yyyymmdd
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
