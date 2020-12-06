import 'package:flutter/material.dart';




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
            
            onTap: () {
             
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




