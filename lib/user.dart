
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:trueconnect/utils/fs_util.dart';

class User extends ChangeNotifier {

  String _id;
  String _name;
  String _email;
  String _age;
  String _mobile;

  String testName = 'test';

  //User(this._id,this._name, this._email, this._age, this._mobile);
  User();

  String get name => _name;

  String get email => _email;

  String get age => _age;

  String get mobile => _mobile;

  String get id => _id;

 
  Map user = {'name': String, 'email': String, 'age': int, 'mobile' : String, 'id' : String};
  
  void updateUser(String name, String email, String age, String mobile)
  {
    user['name'] = name;
    user['email'] = email;
    user['age'] = age;
    user['mobile'] = mobile;
    FS_Util fs = new FS_Util();

    notifyListeners();
    
  } 
}





