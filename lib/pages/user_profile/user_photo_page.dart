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
    print('**** init from new user photo page ****');
    
    photos = appData.currentUser.getPhotos();

    image1=photos.image1;
    image2=photos.image2;
    image3=photos.image3;
    print(image1);
    print(image2);
    print(image3);
    super.initState();
  }

@override
  void dispose() {

  print('**** dispose from new user photo page ****');
  print(image1);
  print(image2);
  print(image3);
  photos.image1=image1;
  photos.image2=image2;
  photos.image3=image3;
  
  appData.currentUser.UserPhotoPageCallBack(photos);

  super.dispose();
}


Future<photoSelection> _asyncSimpleDialog(BuildContext context, int imageindex) async {
  
  return await showDialog<photoSelection>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Photo options'),
          children: <Widget>[
/*
            SimpleDialogOption(
              onPressed: () {

                 setState((){ 

                  switch(imageindex) {
                    case 1:
                      if (image1!=null){
                        if (ImageUtil.IsAssetImage(image1)==false){
                       setprofilestate(1);
                        }
                      }
                       break;
                    case 2:
                      if (image2!=null){
                   if (ImageUtil.IsAssetImage(image2)==false){
                       setprofilestate(2);
                   }
                      }
                       break;
                    case 3:
                      if (image3!=null){
                        if (ImageUtil.IsAssetImage(image3)==false){
                    
                       setprofilestate(3);
                        }
                      }
                      break;
                  }

                  });
                Navigator.pop(context);
              },
              child: const Text('Make profile photo'),
            ),
*/


            SimpleDialogOption(
              onPressed: () {
                setState((){ 
//                  changed=true;
                  switch(imageindex) {
                  case 1:
                    image1=null;
 //                   image1profile=false;
                    break;
                  case 2:
                    image2=null;
 //                   image2profile=false;
                    break;
                  case 3:
                    image3=null;
 //                   image3profile=false;
                    break;
                  }
                
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
           child: image1==null?Image.asset('images/addphoto.png'):image1,
            
            onTap: () {
              _asyncSimpleDialog(context,1);
            },
            ),
            
            GestureDetector(
            child: image2==null?Image.asset('images/addphoto.png'):image2,
            
            onTap: () {
                _asyncSimpleDialog(context,2);
            },
            ),

            GestureDetector(
            child: image3==null?Image.asset('images/addphoto.png'):image3,

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
