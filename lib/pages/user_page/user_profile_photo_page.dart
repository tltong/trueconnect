import 'package:flutter/material.dart';
import 'package:trueconnect/utils/image_util.dart';


enum photoSelection { Gallery, Facebook }

class UserProfilePhotoPage extends StatefulWidget {

  static List<Image> images;

  UserProfilePhotoPage(List<Image> inImages){
    images=inImages;
  }

  @override
  State<StatefulWidget> createState() {
    return UserProfilePhotoPageState();
  }

}

class ImageStruct {

  Image image;
  bool profile;

  ImageStruct(Image inImage, bool inProfile){
    image=inImage;
    profile=inProfile;
  }

}



Future<Image>asyncSimpleDialog(BuildContext context) async {

  return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Photo options'),
            children: <Widget>[

              SimpleDialogOption(
                onPressed: () {

                  ImageUtil.pickImageFromGallery().then((retFile){
                    if(retFile!=null){
                      print('user profile photo page before navigator pop');

                      Image retImage = new Image.file(retFile);

                      Navigator.pop(context,retImage);
                      print('user profile photo page after navigator pop');
                   //   print('user profile photo page selected image : ' + retimage.toString());

//                      return retimage;

                    }
                  
                  });
/*
                  print('user profile photo page before navigator pop');
                  Navigator.pop(context);
                  print('user profile photo page after navigator pop');
*/
                },
                child: const Text('Choose new photo'),
              ),
     ],
        );
      });


}

class UserProfilePhotoPageState extends State<UserProfilePhotoPage>  {


  final PageStorageBucket bucket = PageStorageBucket();
  Image image1,image2,image3;

  @override
    void initState() {
      super.initState();
    }

  @override
    void dispose() {

      super.dispose();
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
            
            onTap: () async {
              print('user profile photo page : before selection ');

               asyncSimpleDialog(context).then((image) async {
                print('user profile photo page : after selection ' + image.toString());

                setState((){
                  image1=image;
                 });

                              });
            

         //     asyncSimpleDialog(context).then(()));
              //print('user profile photo page : after selection ' + image.toString());
            },
            ),
            
            GestureDetector(
            child: image2==null?Image.asset('images/addphoto.png'):image2,
           
            onTap: () {
            },
            ),

            GestureDetector(
            child: image3==null?Image.asset('images/addphoto.png'):image3,
 
            onTap: () {
            },
            ),

          
        ],
      ),
    )
    )
     ;
  }


}




