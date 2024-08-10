//returns todays date as yyyymmdd
String todaysDateYYYYMMDD() {

   //today
   var dateTimeObject = DateTime.now();

   //year in the format yyyy
   String year = dateTimeObject.year.toString();

   //month in format mm
   String month = dateTimeObject.month.toString().padLeft(2, '0');

   //day in format mm
   String day = dateTimeObject.day.toString().padLeft(2, '0');
   

  //final format
  String yyyymmdd = year+month+day;

  return yyyymmdd;

}

//convert string yyyymmdd into datetime object
DateTime? createDateTimeObject(String yyyymmdd){
  try {
    int yyyy = int.parse(yyyymmdd.substring(0, 4));
    int mm = int.parse(yyyymmdd.substring(4, 6));
    int dd = int.parse(yyyymmdd.substring(6, 8));

    return DateTime(yyyy, mm, dd);
  } catch (e) {
    print('Error parsing date: $e');
    return null; // or handle the error as appropriate
  }

}

// convert datetime object into  string yyyymmdd
String convertDateTimeToYYYYMMDD(DateTime dateTime){

  //year in the format yyyy
   String year = dateTime.year.toString();

   //month in format mm
   String month = dateTime.month.toString().padLeft(2, '0');
   

   //day in format mm
   String day = dateTime.day.toString().padLeft(2, '0');
   

  //final format
  String yyyymmdd = year+month+day;

  return yyyymmdd;
}
