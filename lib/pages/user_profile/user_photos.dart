import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import 'package:intl/intl.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../utils/appdata.dart';

enum photoSelection { Gallery, Facebook }

class UserPhotosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserPhotosPageState();
  }
}

class UserPhotosPageState extends State<UserPhotosPage>{

final PageStorageBucket bucket = PageStorageBucket();
 File image1,image2,file3;
 Image image3;
 bool image1profile=false,image2profile=false;


@override
  void initState() {

    image1profile=false;
    image2profile=false;

    image3 = new Image.network(appData.currentUser.imagedownloadlinks[0]);
    print(image3.toString());

    if (appData.currentUser.images!=null){
      switch(appData.currentUser.images.length){
          case 1:
            image1=appData.currentUser.images[0];
          break;
          case 2:
            image1=appData.currentUser.images[0];
            image2=appData.currentUser.images[1];
      }
    }else{
      image1=null;
      image2=null;
    }

    switch(appData.currentUser.profilePhotoIndex){
      case 1:
        image1profile=true;
      break;

      case 2:
        image2profile=true;
      break;



    }

    super.initState();
 
  }

@override
  void dispose() {

    appData.currentUser.images.clear();
    appData.currentUser.profilePhotoIndex=0;

   

    
    List<File> images = new List<File>();

    if (image1!=null){
      images.add(image1);
      print(image1.uri);
    }

    if (image2!=null)
      images.add(image2);

    if (images.length>0)
    {
      appData.currentUser.addImages(images);
    }

    if (image1profile==true)
      appData.currentUser.profilePhotoIndex=1;

    if (image2profile==true)
      appData.currentUser.profilePhotoIndex=2;
    if (image1==null)
      appData.currentUser.profilePhotoIndex--;

    

    super.dispose();
 }

Container photoFrame (File inImage){
  return new Container(
        decoration: new BoxDecoration(
          border: new Border.all(
            color: Colors.green,
            width: 3.0,
            style: BorderStyle.solid
          ),
          image: new DecorationImage(
              image: new FileImage(inImage),
          )
        ));
}

void setprofilestate(int index){

  image1profile=false;
  image2profile=false;

  switch(index){
    case 1:
      image1profile=true;
    break;

    case 2:
      image2profile=true;
    break;
  }



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
                      if (image1!=null)
                       setprofilestate(1);
                       break;
                    case 2:
                      if (image2!=null)
                       setprofilestate(2);
                      break;

                  }

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
                    image1profile=false;
                    break;
                  case 2:
                    image2=null;
                    image2profile=false;
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
                  image1=retimage;
                  break;
                  case 2:
                  image2=retimage;
                  break;
                  case 3:
                  print('image3' + retimage.toString());
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
        crossAxisCount: 4,
        children: <Widget>[
     
            GestureDetector(
            child: image1==null?Image.asset('images/addphoto.png'):
            image1profile==true?photoFrame(image1):Image.file(image1),
            onTap: () {
              _asyncSimpleDialog(context,1);
            },
            ),
            
            GestureDetector(
            child: image2==null?Image.asset('images/addphoto.png'):
            image2profile==true?photoFrame(image2):Image.file(image2),
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