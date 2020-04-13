import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:trueconnect/utils/appdata.dart';
import 'package:trueconnect/utils/fs_util.dart';
import 'dart:io';
import './utils/image_util.dart';
import 'dart:math';
import './pages/user_profile/user_photos.dart';



class Photos {
  int profilePhotoIndex,profilePhotoIndexDB;
  Image image1,image2,image3;
  Image selectedImage1,selectedImage2,selectedImage3;

  String image1uploadpath,image2uploadpath,image3uploadpath;
  String image1downloadpath,image2downloadpath,image3downloadpath;


}


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
  Photos photos;

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


  Image image1,image2,image3;
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

bool photosChanged(){



}


void initialisePhotos(){
  photos.selectedImage1=photos.image1downloadpath==null?null:(ImageUtil.NetworkImageFromLink(photos.image1downloadpath));

  photos.selectedImage2=photos.image2downloadpath==null?null:(ImageUtil.NetworkImageFromLink(photos.image2downloadpath));

  photos.selectedImage3=photos.image3downloadpath==null?null:(ImageUtil.NetworkImageFromLink(photos.image3downloadpath));

  photos.profilePhotoIndex=photos.profilePhotoIndexDB;
}

Photos getPhotos(){

  Photos ret = new Photos();

  ret.image1=photos.selectedImage1;

  ret.image2=photos.selectedImage2;
  ret.image3=photos.selectedImage3;

  ret.profilePhotoIndex=photos.profilePhotoIndex;
  return ret;
}

void UserPhotoPageCallBack(Photos inphotos){

  photos.selectedImage1=inphotos.image1;
  photos.selectedImage2=inphotos.image2;
  photos.selectedImage3=inphotos.image3;
//  print('inside user profile photo index : ' + photos.profilePhotoIndex.toString());
  photos.profilePhotoIndex=inphotos.profilePhotoIndex;

}
void printPhotosParameters(){
    print('selectedImage1 : ' + photos.selectedImage1.toString());
    print('selectedImage2 : ' + photos.selectedImage2.toString());
    print('selectedImage3 : ' + photos.selectedImage3.toString());
    print('profile photo index : ' + photos.profilePhotoIndex.toString());
}

Future<String> processImage(Image image, String path) async {
 
 
  String retstring;
 if (image==null) return null;

  switch(ImageUtil.Imagetype(image)){
    case 'AssetImage':
    case 'NetworkImage':
     // print('AssetImage or NetworkImage');
      retstring=null;
      break;

    case 'FileImage':
  //    print('FileImage');
       File file = ImageUtil.FileFromImage(image);
      
       FS_Util fs = new FS_Util();

       await fs.uploadFile(path,file).then((id){
    //     print('uploading done : ' + id);
       
        retstring=id;
       });

      break;
  }
  return retstring;

}

String generateFilePath(){
  var rng = new Random();
  int index = rng.nextInt(10000);  
  String path = 'memberphotos/'+appData.currentUser.id+'/'+'image'+index.toString();
  return path;
}


Future<String> processImageFull(Image inImage, String oldpath, String newpath) async {

  FS_Util fs = new FS_Util();
  String retstring;
  
  if(inImage==null){
    // this is if user removed a photo. Need to delete old photo on storage
     if(oldpath!=null){
       
      await fs.deleteFile(oldpath).then((id){
        retstring=null;
      });
    }
  }else{
     
    // this is if user selected a new photo.  Need to delete old photo on storage
    await processImage(inImage,newpath).then((id) async {
    if (oldpath!=null ) {
        if (ImageUtil.IsNetworkImage(inImage)==false)
        await fs.deleteFile(oldpath).then((ret){});
    }
    retstring=id;
  
  });

  }
  return retstring;

}

Future<void> processPhotosSelected() async {
  
  // image1

  String image1uploadpath = generateFilePath();
  await processImageFull(photos.selectedImage1,photos.image1uploadpath,image1uploadpath).then((id){
    if (id==null){
      if (ImageUtil.IsNetworkImage(photos.selectedImage1)==false){
      photos.image1uploadpath=null;
      photos.image1downloadpath=null;
    }
    }else{
      photos.image1uploadpath=image1uploadpath;
      photos.image1downloadpath=id;
    }
  });

  // image2

  String image2uploadpath = generateFilePath();
  await processImageFull(photos.selectedImage2,photos.image2uploadpath,image2uploadpath).then((id){
    if (id==null){
      if (ImageUtil.IsNetworkImage(photos.selectedImage2)==false){
      photos.image2uploadpath=null;
      photos.image2downloadpath=null;
      }
    }else{
      photos.image2uploadpath=image2uploadpath;
      photos.image2downloadpath=id;
    }
  });

  // image3

  String image3uploadpath = generateFilePath();
  await processImageFull(photos.selectedImage3,photos.image3uploadpath,image3uploadpath).then((id){
    if (id==null){
      if (ImageUtil.IsNetworkImage(photos.selectedImage3)==false){
      photos.image3uploadpath=null;
      photos.image3downloadpath=null;
      }
    }else{
      photos.image3uploadpath=image3uploadpath;
      photos.image3downloadpath=id;
    }
  });


  print('after uploads');
  print(photos.profilePhotoIndex);
/*
  print(photos.image1downloadpath);
  print(photos.image2downloadpath);
  print(photos.image3downloadpath);
*/
  await updateUserDB();
  photos.profilePhotoIndexDB=photos.profilePhotoIndex;
  initialisePhotos();


}

void printUserSettings()
{
  print('name : ' + name);
  print('country :' + country);
  print('city : ' + city);
  print('dob : ' + dob);
  print('gender : ' + gender);
  print('about : ' + about);
  print('height : ' + height);
  print('occupation : ' + occupation);
  print('education : ' + education);
  print('mobile : ' + mobile);
 // print('imagepaths : ' + imagepaths.toString());
 // print('imagedownloadlinks : ' + imagedownloadlinks.toString());
 // print('profilePhotoIndex : ' + profilePhotoIndex.toString());
  
  print('image1uploadpath : ' + photos.image1uploadpath.toString());

  print('image1downloadpath : ' + photos.image1downloadpath.toString());
  print('image2uploadpath : ' + photos.image2uploadpath.toString());
  print('image2downloadpath : ' + photos.image2downloadpath.toString());
  print('image3uploadpath : ' + photos.image3uploadpath.toString());
  print('image3downloadpath : ' + photos.image3downloadpath.toString());



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

    initialisePhotos();
  }

  void initialiseUserPhotos(){
    selectedProfilePhotoIndex=profilePhotoIndex;
    UserPhotosPageState.changed=false;

    selectedImages.clear();
    for(int i=0; i<imagedownloadlinks.length;i++){
      selectedImages.add(Image.network(appData.currentUser.imagedownloadlinks[i]));
    }

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
    
    initialiseUserPhotos();

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
    profile.putIfAbsent("image1uploadpath", ()=> photos.image1uploadpath);
    profile.putIfAbsent("image1downloadpath", ()=> photos.image1downloadpath);
    profile.putIfAbsent("image2uploadpath", ()=> photos.image2uploadpath);
    profile.putIfAbsent("image2downloadpath", ()=> photos.image2downloadpath);
    profile.putIfAbsent("image3uploadpath", ()=> photos.image3uploadpath);
    profile.putIfAbsent("image3downloadpath", ()=> photos.image3downloadpath);
    profile['profilePhotoIndex'] = photos.profilePhotoIndex.toString();

    

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

    photos= new Photos();
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


      this.photos.image1uploadpath=doc[0]['image1uploadpath'];
      this.photos.image1downloadpath=doc[0]['image1downloadpath'];

      this.photos.image2uploadpath=doc[0]['image2uploadpath'];
      this.photos.image2downloadpath=doc[0]['image2downloadpath'];

      this.photos.image3uploadpath=doc[0]['image3uploadpath'];
      this.photos.image3downloadpath=doc[0]['image3downloadpath'];

     
      
      for (int i=0;i<doc[0]['imagedownloadlinks'].length;i++){
        imagedownloadlinks.add(doc[0]['imagedownloadlinks'][i]);
        imagepaths.add(doc[0]['imagepaths'][i]);
      }
      photos.profilePhotoIndexDB=int.parse(doc[0]['profilePhotoIndex']);

      initialisePhotos();
   
      
    

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