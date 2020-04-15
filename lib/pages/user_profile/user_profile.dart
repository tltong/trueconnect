import 'package:flutter/material.dart';
import 'package:trueconnect/pages/user_profile/user_settings_tabs.dart';
import '../../utils/appdata.dart';
import '../../utils/fs_util.dart';
import './user_photos.dart';
import './edit_user_settings.dart';
import '../../utils/image_util.dart';
import '../../user.dart';
import 'package:carousel_slider/carousel_slider.dart';



class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {

Image profileimage;
Photos photos;

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];



@override
  void initState() {

  //  print('user profile page init');

   

    

/*
    profileimage= new Image.asset(
              'images/jap.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.scaleDown,
            );
*/
    super.initState();

  }

@override
  void dispose() {

    print('user profile page dispose');

    if (appData.currentUser.UserSettingsChanged()==true){

      appData.currentUser.processSelectedUserSettings().then((id){
        print('database updated');
        });
    }else{
    //  print('no change to user details');
    }

    if (appData.currentUser.photosChanged()==true) 
      appData.currentUser.processPhotosSelected();
  


  if (UserPhotosPageState.changed==true)
            {
               print('update database');
              appData.currentUser.processSelectedPhotos().then((id){
             //   print('profile photo index : ' + appData.currentUser.profilePhotoIndex.toString());
                appData.currentUser.updateUserDB();
                print('database updated');
                appData.currentUser.initialiseUserPhotos();
//                UserPhotosPageState.profileIndex=appData.currentUser.profilePhotoIndex;
              });
          }
             else{
     //         print('no change to user photos');
            }


    super.dispose();
 
  }

  @override
  Widget build(BuildContext context) {
   // print('***** user profile page build *****');
     photos = appData.currentUser.getPhotos();
    List<Image> images = appData.currentUser.photos.getSelectedPhotos();
  //  print('image length : '+ images.length.toString());
    profileimage=images.length<1?Image.asset('images/no-image.png'):images[0];
    
    //appData.currentUser.photos.printPhotosParameters();
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserSettingsTabs()),
        );
      },
      child: const Icon(Icons.edit),
    ),
    
    body: 

    ListView(
    children:
    [
     
     new CarouselSlider(
  items: [1,2,3,4,5].map((i) {
    return new Builder(
      builder: (BuildContext context) {
        return new Container(
          width: MediaQuery.of(context).size.width,
          margin: new EdgeInsets.symmetric(horizontal: 5.0),
          decoration: new BoxDecoration(
            color: Colors.amber
          ),
          child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
        );
      },
    );
  }).toList(),
  height: 400.0,
  autoPlay: true
),
     //  profileimage,

       new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
           RaisedButton(
              onPressed: () {
  
              print('***** Print parameters *****');
              appData.currentUser.photos.printPhotosParameters();
              },
            child: Text('Print parameters'),
           ),

                   RaisedButton(
              onPressed: () {
                appData.currentUser.processPhotosSelected();
              },
            child: Text('Process photos'),
           ),

            RaisedButton(
             onPressed: () {
                print(appData.currentUser.photosChanged());
               },
            child: Text('Test stuff'),
           ),

          ],
        )
      ),
    
    ]),

        );
    
  }


}
