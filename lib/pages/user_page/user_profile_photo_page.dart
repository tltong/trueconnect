import 'package:flutter/material.dart';
import 'package:trueconnect/data/simple_image_struct.dart';
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
/*
  return values
  - SimpleImageStruct with image (choosen by user)
  - SimpleImageStruct with no image (user chose to remove photo)
  - null (no action taken)
*/
Future<SimpleImageStruct>asyncSimpleDialog(BuildContext context, SimpleImageStruct inImgStrct) async {

  
  if (inImgStrct.image==null){
    print('user profile photo page : null image ');
      // currently no image is selected, show only one option (choose image)
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
                        Image retImage = new Image.file(retFile);
                        SimpleImageStruct ret = new SimpleImageStruct(retImage,false);
                        print('user profile photo page. selectd image from gallery' + retImage.toString());
                        Navigator.pop(context,ret);
                      }
                    });
                  },
                  child: const Text('Choose new photo'),
                ),
      ],
          );
        });
  }else{
    // current image is not empty.  show all 3 options
        print('user profile photo page, current image is not empty.  show all 3 options');
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
                       print('user profile photo page. return from image picker');
                      if(retFile!=null){
                        print('user profile photo page. photo selected from gallery');
                        Image retImage = new Image.file(retFile);
                        SimpleImageStruct ret = new SimpleImageStruct(retImage,false);
                        print('user profile photo page. selectd image from gallery' + retImage.toString());
                        Navigator.pop(context,ret);
                      }
                      print('user profile photo page. image picker exit');
                    });
                  },
                  child: const Text('Choose new photo'),
                ),

                SimpleDialogOption(
                  onPressed: () {
                        SimpleImageStruct ret = new SimpleImageStruct(null,false);
                        Navigator.pop(context,ret);
                      
                  },
                  child: const Text('Remove photo'),
                ),

                SimpleDialogOption(
                  onPressed: () {
                      
                  },
                  child: const Text('Make profile photo'),
                ),
         
      ],
          );
        });


  }




}

class UserProfilePhotoPageState extends State<UserProfilePhotoPage>  {


  final PageStorageBucket bucket = PageStorageBucket();
  Image image1,image2,image3;
  Container container1, container2, container3;
  var display1,display2,display3;

  @override
    void initState() {
      super.initState();
    }

  @override
    void dispose() {

      super.dispose();
    }


Container profileFrameFromImage (Image inImage){

  var retimage;
  switch(ImageUtil.Imagetype(inImage)){

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
}

Container normalFrameFromImage (Image inImage){

  var retimage;
  print('user profile photo page : image : ' + inImage.toString());
  
  switch(ImageUtil.Imagetype(inImage)){

    case 'NetworkImage':
      print('user profile photo page : network image' );
          
      retimage = new NetworkImage(ImageUtil.ExtractImageString(inImage));
      return new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: retimage,
          )
        ));
    break;

    case 'FileImage':
      print('user profile photo page : file image' );

      retimage = new FileImage(ImageUtil.FileFromImage(inImage));
       return new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: retimage,
          )
        ));
    break;
  }
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

           child: display1==null? Image.asset('images/addphoto.png'):display1,
          
            onTap: () async {

            // ***** TO DO - to extrat image from container *******

              print('user profile photo page. display1 image value ' + display1.child);
            
              SimpleImageStruct imgstrct = new SimpleImageStruct(display1.child,true);


               asyncSimpleDialog(context,imgstrct).then((ret) async {
                
                if (ret!=null){   // do nothing if null
                  setState((){
                   print('user profile photo page. returned image ' + ret.image.toString());
                                      
                   if (ret.profile==true){
                      print('user profile photo page : profile photo' );
                      display1=profileFrameFromImage(ret.image);
                    }else{
                      print('user profile photo page : non profile photo' );
                      display1=normalFrameFromImage(ret.image);
                    }
                 }
                
                );
                }
                

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




