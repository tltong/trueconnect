
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:trueconnect/utils/appdata.dart';
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
  List<File> images = new List<File>();
  List<List<String>> imagelinks = new List<List<String>>();
  bool image1profile=false,image2profile=false;

  //User(this._id,this._name, this._email, this._age, this._mobile);
  User();


  Future<void> updateUserFS(Map profile){

    String id = profile["id"];

    FS_Util fs = new FS_Util();
  }

  void addImage(File image){
    images.add(image);
  }

  void uploadImages(){
    
    for (int i = 0;i<images.length;i++){

      FS_Util fs = new FS_Util();
      String path = 'memberphotos/'+appData.currentUser.id+'/'+'image'+i.toString();
      print(path);
/*
      fs.uploadFile('member/image',images[0]).then((id){
                   print('uploading complete : ' + id);
                 });
*/

    }
  
  }


  void updateImagelinks(File image, List<String> links){
    
    imagelinks.add(links);
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



//https://firebasestorage.googleapis.com/v0/b/trueconnection-702ad.appspot.com/o/member%2FTL%2FimageTL?alt=media&token=11590e32-b942-4533-9c45-a0b33997c1b1
//https://firebasestorage.googleapis.com/v0/b/trueconnection-702ad.appspot.com/o/memberphotos%2F10157353612969091%2Fimage2?alt=media&token=fbd55dbf-cd99-41a4-953f-f78469d1aa9d

  
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





