import 'package:random_string/random_string.dart';




class MiscUtil {




  static String GenerateRandomString (int length){

    String ret = randomAlphaNumeric(length);
    return ret;

  }


  static int CalculateAge(String dobString){

    DateTime birthDate = DateTime.parse(dobString);

    DateTime currentDate = DateTime.now();
      int age = currentDate.year - birthDate.year;
      int month1 = currentDate.month;
      int month2 = birthDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
      return age;

  }


  static String ExtractDateString (DateTime inDate){

    var DayOfWeek = new List(8);
    DayOfWeek[0]='None';
    DayOfWeek[1]='Mon';
    DayOfWeek[2]='Tue';
    DayOfWeek[3]='Wed';
    DayOfWeek[4]='Thu';
    DayOfWeek[5]='Fri';
    DayOfWeek[6]='Sat';
    DayOfWeek[7]='Sun';

    var Month = new List(13);
    Month[0]='None';
    Month[1]='Jan';
    Month[2]='Feb';
    Month[3]='Mar';
    Month[4]='Apr';
    Month[5]='May';
    Month[6]='Jun';
    Month[7]='Jul';
    Month[8]='Aug';
    Month[9]='Sep';
    Month[10]='Oct';
    Month[11]='Nov';
    Month[12]='Dec';
   
    String dateString = 
    
    DayOfWeek[inDate.weekday] + ', ' + Month[inDate.month] + ' ' + inDate.day.toString();
    return dateString.toUpperCase();
  }

static String ExtractDateStringFromTo (DateTime inDateFrom, DateTime inDateTo){

    var DayOfWeek = new List(8);
    DayOfWeek[0]='None';
    DayOfWeek[1]='Mon';
    DayOfWeek[2]='Tue';
    DayOfWeek[3]='Wed';
    DayOfWeek[4]='Thu';
    DayOfWeek[5]='Fri';
    DayOfWeek[6]='Sat';
    DayOfWeek[7]='Sun';

    var Month = new List(13);
    Month[0]='None';
    Month[1]='Jan';
    Month[2]='Feb';
    Month[3]='Mar';
    Month[4]='Apr';
    Month[5]='May';
    Month[6]='Jun';
    Month[7]='Jul';
    Month[8]='Aug';
    Month[9]='Sep';
    Month[10]='Oct';
    Month[11]='Nov';
    Month[12]='Dec';
   
    String dateStringFrom = 
    
    DayOfWeek[inDateFrom.weekday] + ', ' + Month[inDateFrom.month] + ' ' + inDateFrom.day.toString() + 
    ' ' + inDateFrom.hour.toString()+':'+inDateFrom.minute.toString();

    String dateStringTo;

    if (inDateFrom.month == inDateTo.month && inDateFrom.day == inDateTo.day){
      dateStringTo = inDateTo.hour.toString()+':'+inDateTo.minute.toString();
    } else {
      dateStringTo = 
       DayOfWeek[inDateTo.weekday] + ', ' + Month[inDateTo.month] + ' ' + inDateTo.day.toString() + 
       ' ' + inDateTo.hour.toString()+':'+inDateTo.minute.toString();
    }

    String retString = dateStringFrom + ' - ' + dateStringTo;

    return retString.toUpperCase();
  }




}