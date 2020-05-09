import 'package:flutter/material.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../utils/misc_util.dart';
import '../common_strings.dart';

class ImageObject {

  Image image;
  String uploadpath;
  String downloadlink;

  //constructor
  ImageObject(Image image, String uploadpath, String downloadlink){
    this.image=image;
    
    if (uploadpath==null){
      String randomString = MiscUtil.GenerateRandomString(CommonStrings.RandomStringLength());
      this.uploadpath=CommonStrings.VenuePhotoString().toString()+randomString;
    } else {
      this.uploadpath=uploadpath;
    }

    if (image==null){
      this.image=ImageUtil.NetworkImageFromLink(downloadlink);
    }

    this.downloadlink=downloadlink;

  }

  String returnID(){
    return uploadpath;
  }

  Map serialise(){
    Map serialisedObj = new Map();

    serialisedObj['uploadpath']=uploadpath;
    serialisedObj['downloadlink']=downloadlink;
  
    return serialisedObj;

  }



  bool IsEqual (ImageObject inImageObject){

/*
    if (this.image != inImageObject)
      return false;

    if (this.downloadlink != inImageObject.downloadlink)
      return false;
*/

    if (this.uploadpath == inImageObject.uploadpath)
      return true;

    return false;
  }


}