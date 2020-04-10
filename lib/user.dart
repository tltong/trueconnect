
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:trueconnect/utils/appdata.dart';
import 'package:trueconnect/utils/fs_util.dart';
import 'dart:io';
import './utils/image_util.dart';
import 'dart:math';
import './pages/user_profile/user_photos.dart';


class User extends ChangeNotifier {

  String _id;
  String _name;
  String _email;
  String _age;
  String _mobile;
  String country;
  String city;
  String dob;

  String id;

  String testName = 'test';
  Map fbuserprofile;
 // DateTime dob;

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
  int profilePhotoIndex;
  int selectedProfilePhotoIndex=-1;
  

  File image1,image2;
  List<Image> selectedImages = new List<Image>();
  List<File> images = new List<File>();
  List<String> imagepaths = new List<String>();
  List<String> imagedownloadlinks = new List<String>();

  Map<String,String> selectedUserSettings =  Map<String,String>();
  
  //List<List<String>> imagelinks = new List<List<String>>();
  bool image1profile=false,image2profile=false;

  //User(this._id,this._name, this._email, this._age, this._mobile);
  User();


  Future<void> updateUserFS(Map profile){

    String id = profile["id"];

    FS_Util fs = new FS_Util();
  }

// return true if settings are changed
  bool UserSettingsChanged()
  {
    
    if (name!=appData.currentUser.selectedUserSettings["name"]){
      return true;
    }
    if (country!=appData.currentUser.selectedUserSettings["country"]){
      return true;
    }
    if (city!=appData.currentUser.selectedUserSettings["city"]){
      return true;
    }
    if (dob!=appData.currentUser.selectedUserSettings["dob"]){
      return true;
    }
    if (gender!=appData.currentUser.selectedUserSettings["gender"]){
      return true;
    }
   if (about!=appData.currentUser.selectedUserSettings["aboutme"]){
      return true;
    }
   if (height!=appData.currentUser.selectedUserSettings["height"]){
      return true;
    }
   if (occupation!=appData.currentUser.selectedUserSettings["occupation"]){
      return true;
    }
   if (education!=appData.currentUser.selectedUserSettings["education"]){
      return true;
    }
   if (mobile!=appData.currentUser.selectedUserSettings["mobile"]){
      return true;
    }
    return false;
  }

  void initialiseUserSettings()
  {
    appData.currentUser.selectedUserSettings["name"] = name;
    appData.currentUser.selectedUserSettings["dob"] = dob;
    appData.currentUser.selectedUserSettings["country"] = country;
    appData.currentUser.selectedUserSettings["city"] = city;
    appData.currentUser.selectedUserSettings["gender"] = gender;
    appData.currentUser.selectedUserSettings["aboutme"]= about;
    appData.currentUser.selectedUserSettings["height"] = height;
    appData.currentUser.selectedUserSettings["occupation"] = occupation;
    appData.currentUser.selectedUserSettings["education"] = education;
    appData.currentUser.selectedUserSettings["mobile"] = mobile;



  }

  Future<void> processSelectedUserSettings() async {

    name = appData.currentUser.selectedUserSettings["name"];
    dob = appData.currentUser.selectedUserSettings["dob"];
    country = appData.currentUser.selectedUserSettings["country"];
    city = appData.currentUser.selectedUserSettings["city"];
    gender = appData.currentUser.selectedUserSettings["gender"];
    about = appData.currentUser.selectedUserSettings["aboutme"];
    height = appData.currentUser.selectedUserSettings["height"];
    occupation = appData.currentUser.selectedUserSettings["occupation"];
    education = appData.currentUser.selectedUserSettings["education"];
    mobile = appData.currentUser.selectedUserSettings["mobile"];
    await updateUserDB();
    return;

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
/*
   bool UserSettingsChanged(){

    bool ret = false;

    if (name!=appData.currentUser.selectedUserSettings["name"])
      return false;

    return true;
/*
    namectrl.text=appData.currentUser.selectedUserSettings["name"];
    countryctrl.text=appData.currentUser.selectedUserSettings["country"];
    cityctrl.text=appData.currentUser.selectedUserSettings["city"];
    dobctrl.text=appData.currentUser.selectedUserSettings["dob"];
    genderString=appData.currentUser.selectedUserSettings["gender"];
    aboutctrl.text=appData.currentUser.selectedUserSettings["aboutme"];
    heightctrl.text=appData.currentUser.selectedUserSettings["height"];
    occupationctrl.text=appData.currentUser.selectedUserSettings["occupation"];
    educationString=appData.currentUser.selectedUserSettings["education"];
    mobilectrl.text=appData.currentUser.selectedUserSettings["mobile"];
*/
  }
*/

  Future<void> processSelectedPhotos() async {

     List<String> downloadlinks = new List<String>();
     List<String> temp_imagepaths = new List<String>();
    List<String> temp_imagedownloadlinks = new List<String>();

    //imagedownloadlinks.clear();

    int i=0;
    int j=0;

    for (Image image in selectedImages){
        
      if (image.toString().contains('AssetImage')){
        i++;
        continue;
      }

      if ((ImageUtil.ExtractImageString(image))!=null){
        temp_imagepaths.add(imagepaths[i].toString());
        temp_imagedownloadlinks.add(imagedownloadlinks[i].toString());
        if (UserPhotosPageState.profileIndex==i){
          appData.currentUser.profilePhotoIndex=temp_imagepaths.length-1;
        }
      }
      
      else{

        File file = ImageUtil.FileFromImage(image);
        var rng = new Random();
        int index = rng.nextInt(10000);  
        FS_Util fs = new FS_Util();
        String path = 'memberphotos/'+appData.currentUser.id+'/'+'image'+index.toString();
        await fs.uploadFile(path,file).then((id){
        temp_imagedownloadlinks.add(id);
        temp_imagepaths.add(path);

        if (UserPhotosPageState.profileIndex==i){
          appData.currentUser.profilePhotoIndex=temp_imagepaths.length-1;
        }
        
        });
        
      }
      i++;
    }
    
    for (int i=0;i<imagedownloadlinks.length;i++){
      String link = imagedownloadlinks[i];
       if (temp_imagedownloadlinks.contains(link)==false){
          FS_Util fs = new FS_Util();
          
          await fs.deleteFile(imagepaths[i]);
        }
    }

    imagedownloadlinks= temp_imagedownloadlinks;
    imagepaths=temp_imagepaths;

    selectedImages.clear();
   // print('profile photo index : ' + appData.currentUser.profilePhotoIndex.toString());


  }

  Future<void> uploadImages() async {
    
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
    profile.putIfAbsent("profilePhotoIndex", ()=> profilePhotoIndex);
    profile.putIfAbsent("dob", ()=> dob);
    profile.putIfAbsent("country", ()=> country);
    profile.putIfAbsent("city", ()=> city);
    profile.putIfAbsent("gender", ()=> gender);
    profile.putIfAbsent("about", ()=> about);
    profile.putIfAbsent("height", ()=> height);
    profile.putIfAbsent("occupation", ()=> occupation);   
    profile.putIfAbsent("education", ()=> education);
    profile.putIfAbsent("mobile", ()=> mobile);
  

  /*

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
*/
   // print(profile);
   // print('document ID : ' + documentID);

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

    FS_Util fs = new FS_Util();
   await fs.queryDoc('users','id',id).then((doc){
    if (doc.length==0){
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
      
      for (int i=0;i<doc[0]['imagedownloadlinks'].length;i++){
        imagedownloadlinks.add(doc[0]['imagedownloadlinks'][i]);
        imagepaths.add(doc[0]['imagepaths'][i]);
      }
   
      
    

/*
      for(int i=0;i<imagedownloadlinks.length;i++){
          //print(imagedownloadlinks[i]);

          ImageUtil.Fetchfromweb(imagedownloadlinks[i]).then( (ret) {
            print('image added');
            images.add(ret);
        });

      }
  */   
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





