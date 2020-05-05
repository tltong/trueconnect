import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_image_picker/model/photo.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_facebook_image_picker/flutter_facebook_image_picker.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' show get;
import './fs_util.dart';
import '../data/image_struct.dart';


class ImageUtil {

static Future<File> pickImageFromGallery() async {
    File tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    return tempImage;
  }


static Future<List<ImageStruct>> uploadImages(List<ImageStruct> inImages) async{

  List<ImageStruct> ret = new List<ImageStruct>();

  FS_Util fs = new FS_Util();

  for (int i=0;i<inImages.length;i++){

    if (inImages[i].downloadlink!=null){    // no need to do upload
      ret.add(inImages[i]);
      continue;
    }else{
       await fs.uploadFile(inImages[i].uploadpath,FileFromImage(inImages[i].image)).then((link)
      {
        
        ImageStruct imagestruct = ImageStruct(NetworkImageFromLink(link),inImages[i].uploadpath,link);
        ret.add(imagestruct);
      });
    }
  }
  return ret;
}


static String Imagetype(Image image){

  if (IsAssetImage(image)==true)
    return 'AssetImage';

  if (IsFileImage(image)==true)
    return 'FileImage';

  if (IsNetworkImage(image)==true)
    return 'NetworkImage';
}

static String ExtractImageStringByType(Image image, String imagetype){

  switch(imagetype){
    case 'AssetImage':
      int index1 = image.toString().indexOf("images");
      if (index1==-1) return null;
      int index2 = image.toString().lastIndexOf("\"");
      return image.toString().substring(index1,index2).toString();
    break;

    case 'FileImage':
      int index1 = image.toString().indexOf("/data");
      if (index1==-1) return null;
      int index2 = image.toString().lastIndexOf("\"");
      return image.toString().substring(index1,index2).toString();
    break;

    case 'NetworkImage':
      int index1 = image.toString().indexOf("http");
      if (index1==-1) return null;
      int index2 = image.toString().lastIndexOf("\"");
      return image.toString().substring(index1,index2).toString();
    break;
  }
}

static bool IsAssetImage(Image image){
  if(image.toString().contains('AssetImage')){
    return true;
  }else{
    return false;
  }
}
static bool IsFileImage(Image image){
  if(image.toString().contains('FileImage')){
    return true;
  }else{
    return false;
  }
}
static bool IsNetworkImage(Image image){
  if(image.toString().contains('NetworkImage')){
    return true;
  }else{
    return false;
  }
}

static Image NetworkImageFromLink (String link){
    Image ret;
    ret = new Image.network(link);
    return ret;
}

static String ExtractImageString (Image image){

  int index1 = image.toString().indexOf("http");
  
  if (index1==-1) return null;

  int index2 = image.toString().lastIndexOf("\"");

  return image.toString().substring(index1,index2).toString();

}

// works only for file image (not network image)
static File FileFromImage (Image image){
  
  int index1 = image.toString().indexOf("/data");
  
  if (index1==-1) return null;

  int index2 = image.toString().lastIndexOf("\"");

  String filepath = image.toString().substring(index1,index2).toString();

  File file = new File(filepath);
  
  return file;
                 
}


static Future<File> Fetchfromweb(String site) async {

  print('getting url');
  
  var response = await get(site);
  //print('done');
//  File imagefile = File.fromUri(Uri.dataFromBytes(response.));
//  print(response.);
  //File imagefile = new File.fromRawPath(response.bodyBytes);
  Uri uri = new Uri.dataFromBytes(response.bodyBytes);
  File ret = new File.fromRawPath(uri.data.contentAsBytes());
  print(ret.uri);
//  print(imagefile.toString());
  
//  Image image1 = new Image.file(imagefile);
 // print(image1.toString());

 // Image image2 = new Image.network(site);
 // image2.
 // print(image2.toString());

//  return imagefile;
//  response.bodyBytes;
  //print('fetching image ' + site);
  //Uri uri = Uri(path: site, queryParameters: {});
  //print('URI ' + uri.toFilePath().toString());
  

 // File ret = new File(uri.toFilePath());
//    var imageId = await ImageDownloader.downloadImage(site);

  //  var path = await ImageDownloader.findPath(imageId);


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