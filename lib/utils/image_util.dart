import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'dart:io';
 
import 'package:flutter/material.dart';



class ImageUtil {

static Future<File> pickImageFromGallery() async {
    File tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    return tempImage;
  }




}