import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import 'package:intl/intl.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../utils/appdata.dart';
import '../../user.dart';

enum photoSelection { Gallery, Facebook }

class UserPhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserPhotoPageState();
  }
}

class UserPhotoPageState extends State<UserPhotoPage>{

  final PageStorageBucket bucket = PageStorageBucket();

  Photos photos;
  Image image1,image2,image3;
  int profileIndex;

@override
  void initState() {
   // print('**** init from new user photo page ****');
    
    photos = appData.currentUser.getPhotos();
    
    image1=photos.image1;
    image2=photos.image2;
    image3=photos.image3;
    profileIndex=photos.profilePhotoIndex;
    //print(image1);
    //print(image2);
    //print(image3);
    //print('profile photo : ' + profileIndex.toString());
    super.initState();
  }

@override
  void dispose() {

 // print('**** dispose from new user photo page ****');
  updateCentralPhotos();
  
  super.dispose();
}

void updateCentralPhotos(){
  photos.image1=image1;
  photos.image2=image2;
  photos.image3=image3;
  photos.profilePhotoIndex=profileIndex;
  appData.currentUser.UserPhotoPageCallBack(photos);

}


Future<photoSelection> _asyncSimpleDialog(BuildContext context, int imageindex) async {
  
  return await showDialog<photoSelection>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Photo options'),
          children: <Widget>[

            SimpleDialogOption(
              onPressed: () {

                 setState((){ 

                  switch(imageindex) {
                    case 1:
                      if (image1!=null) profileIndex=1;
                      break;
                    case 2:
                      if (image2!=null) profileIndex=2;
                      break;
                    case 3:
                      if (image3!=null) profileIndex=3;
                      break;
                  }
                     updateCentralPhotos();

                  });
               
                Navigator.pop(context);
              },
              child: const Text('Make profile photo'),
            ),

            SimpleDialogOption(
              onPressed: () {
                setState((){ 

                  switch(imageindex) {
                  case 1:
                    image1=null;
                    if (profileIndex==1) profileIndex=0;
                    break;
                  case 2:
                    image2=null;
                    if (profileIndex==2) profileIndex=0;
                    break;
                  case 3:
                    image3=null;
                    if (profileIndex==3) profileIndex=0;
                    break;
                  }
                  updateCentralPhotos();
                  });
              
              Navigator.pop(context); 
              },
              child: const Text('Remove photo'),
            ),


            SimpleDialogOption(
              onPressed: () {
              
                ImageUtil.pickImageFromGallery().then((retimage){
              if (retimage!=null)
             
                setState((){ 
                  
                  switch(imageindex) {
                  case 1:
                    image1=Image.file(retimage);
                  break;
                  case 2:
                    image2=Image.file(retimage);
                  break;
                  case 3:
                    image3=Image.file(retimage);
                  break;
                }
                updateCentralPhotos();
                  });
              });
              
              Navigator.pop(context); 
              },
              child: const Text('Choose new photo'),
            ),
            
          ],
        );
      });
}

Container photoFrameFromImage (Image inImage){

  var retimage;
  switch(ImageUtil.Imagetype(inImage)){

    case 'NetworkImage':
      retimage = new NetworkImage(ImageUtil.ExtractImageString(inImage));
      return new Container(
        decoration: new BoxDecoration(
          border: new Border.all(
            color: Colors.green,
            width: 3.0,
            style: BorderStyle.solid
          ),
          image: new DecorationImage(
              image: retimage,
          )
        ));
    break;

    case 'FileImage':
      retimage = new FileImage(ImageUtil.FileFromImage(inImage));
       return new Container(
        decoration: new BoxDecoration(
          border: new Border.all(
            color: Colors.green,
            width: 3.0,
            style: BorderStyle.solid
          ),
          image: new DecorationImage(
              image: retimage,
          )
        ));
    break;

  }
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: 
      
      PageStorage(  
      bucket: bucket, 
      child:
      GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
     
            GestureDetector(

//               child: Image.asset('images/addphoto.png'),
           child: image1==null?Image.asset('images/addphoto.png'):
           profileIndex==1?photoFrameFromImage(image1):image1,
            
            onTap: () {
              _asyncSimpleDialog(context,1);
            },
            ),
            
            GestureDetector(
            child: image2==null?Image.asset('images/addphoto.png'):
            profileIndex==2?photoFrameFromImage(image2):image2,
            
            onTap: () {
                _asyncSimpleDialog(context,2);
            },
            ),

            GestureDetector(
            child: image3==null?Image.asset('images/addphoto.png'):
            profileIndex==3?photoFrameFromImage(image3):image3,

            onTap: () {
                _asyncSimpleDialog(context,3);
            },
            ),

          
        ],
      ),
    )
    
    
    );
  }


}
