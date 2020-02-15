import 'package:trueconnect/user.dart';


class AppData {
  static final AppData _appData = new AppData._internal();
  
  String fbtoken;
  User currentUser;
  
  
  factory AppData() {
    return _appData;
  }
  AppData._internal();
}
final appData = AppData();