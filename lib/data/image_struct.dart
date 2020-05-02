import 'package:flutter/material.dart';

class ImageStruct{

  Image image;
  String uploadpath;
  String downloadlink;

  ImageStruct(Image image, String uploadpath, String downloadlink){
    this.image=image;
    this.uploadpath=uploadpath;
    this.downloadlink=downloadlink;
  }


}