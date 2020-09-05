import 'package:random_string/random_string.dart';

class MiscUtil {

  static String GenerateRandomString (int length){

    String ret = randomAlphaNumeric(length);
    return ret;

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

}