import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_image_picker/model/photo.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_facebook_image_picker/flutter_facebook_image_picker.dart';




class ImageUtil {

static Future<File> pickImageFromGallery() async {
    File tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    return tempImage;
  }

static Future<List<Photo>> pickImagefromFacebook(BuildContext context, String _accessToken) async {
  List<Photo> _photos = [];
  
 
Navigator.of(context).push(
              MaterialPageRoute(
                
              builder: (BuildContext context){


    return FacebookImagePicker(
                      _accessToken,
                      onDone: (items) {
                        Navigator.pop(context);
                      //  setState(() {
                      //    _error = null;
                          _photos = items;
                      //  });
                      },
                      onCancel: () => Navigator.pop(context),
                    );
    
    
    
    }
             
             
              ),
              
            );


}


}