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

 Image image1,image2,image3;
 static int profileIndex;
 static bool changed=false;

 bool image1profile=false,image2profile=false,image3profile=false;

@override
  void initState() {
    print('************** USER PHOTOS INIT ********************');
    print('image1profile before : ' + image1profile.toString() + ', image2profile :' + image2profile.toString() + ', image3profile : ' + image3profile.toString());

    profileIndex = appData.currentUser.selectedProfilePhotoIndex;
  
    image1profile=false;
    image2profile=false;
    image3profile=false;
    
    switch(profileIndex){
      case 0:
        image1profile=true;
        break;
      case 1:
        image2profile=true;
        break;
      case 2:
        image3profile=true;
        break;
    }
  
    print('selected photos : ' + appData.currentUser.selectedImages.toString());
    print('imagedownloadlinks : ' + appData.currentUser.imagedownloadlinks.toString());
    print('profile index : ' + profileIndex.toString());
     print('image1profile after : ' + image1profile.toString() + ', image2profile :' + image2profile.toString() + ', image3profile : ' + image3profile.toString());
  
 
    print('selected images : '+ appData.currentUser.selectedImages.toString());
    print('image type : ' + ImageUtil.Imagetype(appData.currentUser.selectedImages[0]));
    print('image string ' + ImageUtil.ExtractImageStringByType(appData.currentUser.selectedImages[0],ImageUtil.Imagetype(appData.currentUser.selectedImages[0])));
    
    image1=appData.currentUser.selectedImages.length<1?null:appData.currentUser.selectedImages[0];
    image2=appData.currentUser.selectedImages.length>1?appData.currentUser.selectedImages[1]:null;
    image3=appData.currentUser.selectedImages.length>1?appData.currentUser.selectedImages[2]:null;

/*
   // print(appData.currentUser.selectedImages[0].toString()); 
      if (appData.currentUser.selectedImages.length<1){
        print('selectedImages[0] empty');
      }else{
        print('selectedImages[0] not empty');
        print(appData.currentUser.selectedImages[0]);
        print('image type : ' + ImageUtil.Imagetype(appData.currentUser.selectedImages[0]));
        String imageString = ImageUtil.ExtractImageStringByType(appData.currentUser.selectedImages[0], 'AssetImage');
        print('image string : ' + imageString);
//        image1=Image.asset('images/addphoto.png');
//        image1=appData.currentUser.selectedImages[0];
//        image1=new Image.asset(imageString);
       // print(image1.toString());
      }
*/
//    image1=appData.currentUser.selectedImages.length<1?null:appData.currentUser.selectedImages[0];
 //   image2=appData.currentUser.selectedImages.length>1?appData.currentUser.selectedImages[1]:null;
 //   image3=appData.currentUser.selectedImages.length>1?appData.currentUser.selectedImages[2]:null;


/*
    if (appData.currentUser.selectedImages.length<1){
    if (appData.currentUser.imagedownloadlinks.length>0){
      image1=new Image.network(appData.currentUser.imagedownloadlinks[0]);
    }
    if (appData.currentUser.imagedownloadlinks.length>1){
      image2=new Image.network(appData.currentUser.imagedownloadlinks[1]);
    }
    if (appData.currentUser.imagedownloadlinks.length>2){
      image3=new Image.network(appData.currentUser.imagedownloadlinks[2]);
    }
    }    
     else{

       if (appData.currentUser.selectedImages.length>0){
        if (ImageUtil.IsAssetImage(appData.currentUser.selectedImages[0])==true)
        print('image1 is asset image');
         image1=null;
      }else{
          image1=appData.currentUser.selectedImages[0];
      }
      if (appData.currentUser.selectedImages.length>1){
        if (ImageUtil.IsAssetImage(image1)==false)
         image2=appData.currentUser.selectedImages[1];
      }
      if (appData.currentUser.selectedImages.length>2){
        if (ImageUtil.IsAssetImage(image1)==false)
          image3=appData.currentUser.selectedImages[2];
      }
    }
*/
  
    super.initState();
 
  }

@override
  void dispose() {

    appData.currentUser.images.clear();

    appData.currentUser.selectedImages.clear();
/*
    print('image1 : ');
    if (image1!=null) print(image1.toString());

    print('image2 : ');
    if (image2!=null) print(image2.toString());

    print('image3 : ');
    if (image3!=null) print(image3.toString());
*/
    if (image1!=null)
     appData.currentUser.selectedImages.add(image1);
    else
     appData.currentUser.selectedImages.add(Image.asset('images/addphoto.png'));

    if (image2!=null)
      appData.currentUser.selectedImages.add(image2);
    else
     appData.currentUser.selectedImages.add(Image.asset('images/addphoto.png'));

    if (image3!=null)
      appData.currentUser.selectedImages.add(image3);
    else
     appData.currentUser.selectedImages.add(Image.asset('images/addphoto.png'));

   // appData.currentUser.selectedProfilePhotoIndex=0;

    profileIndex=0;
    if (image1profile==true)
      profileIndex=0;

    if (image2profile==true)
      profileIndex=1;

    if (image3profile==true)
      profileIndex=2;

  //  print("selected profile photo : " + appData.currentUser.selectedProfilePhotoIndex.toString());
   appData.currentUser.selectedProfilePhotoIndex=profileIndex;
   print('************** USER PHOTOS DISPOSE ********************');
    print('selected photos : ' + appData.currentUser.selectedImages.toString());
    print('imagedownloadlinks : ' + appData.currentUser.imagedownloadlinks.toString());
    print('profile photo : ' + profileIndex.toString());
    print('image1profile : ' + image1profile.toString() + ', image2profile :' + image2profile.toString() + ', image3profile : ' + image2profile.toString());
    print('changed : ' + changed.toString());

    

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

Container photoFrameFromImage (Image inImage){

  var retimage;

  switch(ImageUtil.ExtractImageString(inImage)){

    // this code crashes a crash
    case 'AssetImage':
      retimage=inImage;
        return new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: retimage,
          )
        ));
    break;

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



  if (inImage.toString().contains('NetworkImage')){
    retimage = new NetworkImage(ImageUtil.ExtractImageString(inImage));
  }else{
   retimage = new FileImage(ImageUtil.FileFromImage(inImage));
  }

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

}

void setprofilestate(int index){

  image1profile=false;
  image2profile=false;
  image3profile=false;
  changed=true;

  switch(index){
    case 1:
      image1profile=true;
    break;

    case 2:
      image2profile=true;
      break;

    case 3:
      image3profile=true;
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
            SimpleDialogOption(
              onPressed: () {
                setState((){ 
                  changed=true;
                  switch(imageindex) {
                  case 1:
                    image1=null;
                    image1profile=false;
                    break;
                  case 2:
                    image2=null;
                    image2profile=false;
                    break;
                  case 3:
                    image3=null;
                    image3profile=false;
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
                changed=true;
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
        crossAxisCount: 4,
        children: <Widget>[
     
            GestureDetector(

//               child: Image.asset('images/addphoto.png'),
           child: 
            image1==null?
            Image.asset('images/addphoto.png'):
            ImageUtil.Imagetype(image1)=='AssetImage'?Image.asset('images/addphoto.png'):
            image1profile==true?photoFrameFromImage(image1):image1,


  //          image1profile==true?photoFrameFromImage(image1):image1,
            
            onTap: () {
              _asyncSimpleDialog(context,1);
            },
            ),
            
            GestureDetector(
            child: 
            
            image2==null?
            Image.asset('images/addphoto.png'):
            ImageUtil.Imagetype(image2)=='AssetImage'?Image.asset('images/addphoto.png'):
            image2profile==true?photoFrameFromImage(image2):image2,

            
            
            onTap: () {
                _asyncSimpleDialog(context,2);
            },
            ),

            GestureDetector(
            child: 
            
            image3==null?
            Image.asset('images/addphoto.png'):
            ImageUtil.Imagetype(image3)=='AssetImage'?Image.asset('images/addphoto.png'):
            image3profile==true?photoFrameFromImage(image3):image3,

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