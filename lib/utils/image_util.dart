import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_image_picker/model/photo.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_facebook_image_picker/flutter_facebook_image_picker.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' show get;
import './fs_util.dart';
import '../data/image_struct.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';


class ImageUtil {


// Example usage :
// File imgFile = await ImageUtil.pickImageFromGallery();
static Future<File> pickImageFromGallery() async {
    File tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    return tempImage;
  }


static Future<List<Image>> pickMultipleImages() async {

  List<Asset> resultList = List<Asset>();

  try{
    resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
      //  selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Pick Photos",
         // allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
  } on Exception catch (e){
    
  }
  List<Image> ret = new List<Image>();

  for (Asset asset in resultList){


   var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);

   Uri imgUri=Uri.file(path);
   File imgFile = File.fromUri(imgUri);


 //  print(path);
/*
    ByteData imgByteData = await asset.getByteData();
    ByteBuffer imgByteBuffer = imgByteData.buffer;
    Uint8List list =  imgByteBuffer.asUint8List();
    Image img2 = Image.memory(list);
*/
      

    Image img = Image.file(imgFile);
 
    ret.add(img);
  }

  return ret;
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

  if (IsMemoryImage(image)==true)
    return 'MemoryImage';

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
static bool IsMemoryImage(Image image){
  if(image.toString().contains('MemoryImage')){
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

static List<Image> NetworkImagesFromLinks (List<String> links){


  List<Image> ret = new List<Image>();
 

  for (int i=0; i<links.length; i++){
    Image image = NetworkImageFromLink(links[i]);
    ret.add(image);
  }

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

/*
static Future<List<Photo>> pickImagefromFacebook(BuildContext context, String _accessToken) async {
  List<Photo> _photos = [];
  
 
Navigator.of(context).push(
              MaterialPageRoute(
                
              builder: (BuildContext context){


    return pickImagefromFacebook(
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
            );}
*/
}
