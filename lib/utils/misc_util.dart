import 'package:random_string/random_string.dart';

class MiscUtil {

  static String GenerateRandomString (int length){

    String ret = randomAlphaNumeric(length);
    return ret;

  }

}