
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
  String name;
  String gender;
  String about;
  String height;
  String occupation;
  String education;
  String mobile;
  String email;
  String documentID;
  String first_name;
  String last_name;

  File image1,image2;
  List<File> images = new List<File>();
  List<String> imagepaths = new List<String>();
  List<String> imagedownloadlinks = new List<String>();


  //List<List<String>> imagelinks = new List<List<String>>();
  bool image1profile=false,image2profile=false;

  //User(this._id,this._name, this._email, this._age, this._mobile);
  User();


  Future<void> updateUserFS(Map profile){

    String id = profile["id"];

    FS_Util fs = new FS_Util();
  }

  void addImages(List<File> imagesin){
   
    images.clear();
    for (int i=0;i<imagesin.length;i++){
      images.add(imagesin[i]);
      
    }
  
  }

  void addImage(File image){
    images.add(image);
  }

  Future<void> uploadImages() async {
    
   // 
    imagepaths.clear();
    imagedownloadlinks.clear();

    for (int i = 0;i<images.length;i++){

      FS_Util fs = new FS_Util();
      String path = 'memberphotos/'+appData.currentUser.id+'/'+'image'+i.toString();
      
      await fs.uploadFile(path,images[i]).then((id){
       
        imagepaths.add(path);
         
       imagedownloadlinks.add(id);
               
        });
    }
    
    return;
  }

  Future<void> updateUserDB() async {
    Map<String, dynamic> profile = new Map<String, dynamic>();
  
    profile.putIfAbsent("name", ()=> name);
    profile.putIfAbsent("id", ()=> id);
    profile.putIfAbsent("first_name", ()=> first_name);
    profile.putIfAbsent("imagepaths", ()=> imagepaths);
    profile.putIfAbsent("imagedownloadlinks", ()=> imagedownloadlinks);

  

    profile.putIfAbsent("last_name", ()=> last_name);
    profile.putIfAbsent("documentID", ()=> documentID);
    profile.putIfAbsent("country", ()=> country);
    profile.putIfAbsent("city", ()=> city);
    profile.putIfAbsent("dob", ()=> dob);
    profile.putIfAbsent("gender", ()=> gender);
    profile.putIfAbsent("about", ()=> about);
    profile.putIfAbsent("height", ()=> height);
    profile.putIfAbsent("occupation", ()=> occupation);   
    profile.putIfAbsent("education", ()=> education);
    profile.putIfAbsent("email", ()=> email);
    profile.putIfAbsent("mobile", ()=> mobile);

    print(profile);
    FS_Util fs = new FS_Util();
   await fs.updateRecord('users', documentID, profile).then((ret){
       return;
    });



  }

/*
  void updateImagelinks(File image, List<String> links){
    
   // imagelinks.add(links);
  }
  */


  Future<void> initialise(Map profile) async {


    fbuserprofile = profile;
    this.id=profile["id"];

    this.name=fbuserprofile["name"];
    
    this.email=fbuserprofile["email"];
    this.id=fbuserprofile["id"];
    this.first_name=fbuserprofile["first_name"];
    this.last_name=fbuserprofile["last_name"];

  //print('initialise user');

    FS_Util fs = new FS_Util();
   await fs.queryDoc('users','id',id).then((doc){

    if (doc.length==0){
    //  print('user does not yet exist');
     
      fs.addRecord('users', fbuserprofile).then((ret){
        documentID = ret;
        fbuserprofile.putIfAbsent("documentID", () => ret);

      fs.updateRecord('users', ret, fbuserprofile).then((ret){
        return;
        });

      });
    }else{
      
      this.name=doc[0]['name'];
      this.country=doc[0]['country'];
      this.city=doc[0]['city'];
      this.dob=doc[0]['dob'];
      this.gender=doc[0]['gender'];
      this.about=doc[0]['about'];
      this.height=doc[0]['height'];
      this.occupation=doc[0]['occupation'];
      this.education=doc[0]['education'];
      this.email=doc[0]['email'];
      this.mobile=doc[0]['mobile'];
      this.documentID=doc[0]['documentID'];
      return;
    }
  });



  }

  User.namedConst(Map profile) {

    fbuserprofile = profile;
    this.id=profile["id"];
    
  }


  //String get name => fbuserprofile["name"];

  //String get email => fbuserprofile["email"];

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





