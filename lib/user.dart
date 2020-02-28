
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:trueconnect/utils/fs_util.dart';
import 'dart:io';


class User extends ChangeNotifier {

  String _id;
  String _name;
  String _email;
  String _age;
  String _mobile;
  String country;
  String city;

  String id;

  String testName = 'test';
  Map fbuserprofile;
  DateTime dob;
  String gender;
  String about;
  String height;
  String occupation;
  String education;
  String mobile;

  File image1,image2;
  String image1path,image2path;
  bool image1profile, image2profile;

  //User(this._id,this._name, this._email, this._age, this._mobile);
  User();


  Future<void> updateUserFS(Map profile){

    String id = profile["id"];

    FS_Util fs = new FS_Util();
    

  }


  User.namedConst(Map profile) {

    fbuserprofile = profile;
    this.id=profile["id"];

    FS_Util fs = new FS_Util();
    fs.queryDoc('users','id',profile["id"]).then((doc){

    if (doc.length==0){
      fs.addRecord('users', profile).then((ret){
        print('added record' + ret);
      });
    }
  
  });



  }


  String get name => fbuserprofile["name"];

  String get email => fbuserprofile["email"];

  String get age => _age;

  //String get mobile => _mobile;

  String get id2 => _id;

 
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





