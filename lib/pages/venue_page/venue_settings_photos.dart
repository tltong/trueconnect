import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import 'package:intl/intl.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../utils/appdata.dart';
import '../../user.dart';

enum photoSelection { Gallery, Facebook }


List<Image> images;


class VenueSettingsPhotos extends StatefulWidget {

  static String testString;
  static List<Image> vPhotos;       // return value

  VenueSettingsPhotos(List<Image> inImages){

    images=inImages;
    vPhotos = new List<Image>();

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VenueSettingsPhotosState();
  }
}

class VenueSettingsPhotosState extends State<VenueSettingsPhotos>{

  final PageStorageBucket bucket = PageStorageBucket();

  Photos photos;
  Image image1,image2,image3;
  int profileIndex;

updateVphotos(Image inImage1, Image inImage2, Image inImage3){

  if (VenueSettingsPhotos.vPhotos != null)
    VenueSettingsPhotos.vPhotos.clear();
  
  if (images!=null)
    images.clear();

  if (inImage1!=null){
    VenueSettingsPhotos.vPhotos.add(inImage1);
    images.add(inImage1);
  }

  if (inImage2!=null){
    VenueSettingsPhotos.vPhotos.add(inImage2);
    images.add(inImage2);
  }

  if (inImage3!=null){
    VenueSettingsPhotos.vPhotos.add(inImage3);
    images.add(inImage3);
  }
}



@override
  void initState() {
  
    if (images!=null){

      if (images.length>0) {
        image1=images[0];
      }

      if (images.length>1)  
        image2=images[1];

      if (images.length>2)  
        image3=images[2];

    }

    updateVphotos(image1,image2,image3);



    super.initState();
  }

@override
  void dispose() {
    

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
           
                  });
              updateVphotos(image1,image2,image3);
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
              updateVphotos(image1,image2,image3);
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
    return  

    
    Scaffold(
      body: 
      PageStorage(  
      bucket: bucket, 
      child:
      GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
     
            GestureDetector(

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
    )

      //WillPopScope
     
     ;
  }


}
