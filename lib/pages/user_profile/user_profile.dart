import 'package:flutter/material.dart';
import 'package:trueconnect/pages/user_profile/user_settings_tabs.dart';
import '../../utils/appdata.dart';
import '../../utils/fs_util.dart';
import './user_photos.dart';
import './edit_user_settings.dart';
import '../../utils/image_util.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {

@override
  void initState() {
    //print('init from user profile');
    super.initState();

  }

@override
  void dispose() {


    if (appData.currentUser.UserSettingsChanged()==true){

      appData.currentUser.processSelectedUserSettings().then((id){
        print('database updated');
        });
    }else{
      print('no change to user details');
    }
  
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
              print('no change to user photos');
            }


    super.dispose();
 
  }

  @override
  Widget build(BuildContext context) {

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

  //    ListView(
  //    children:[
    ListView(
    children:
    [
         Image.asset(
              'images/jap.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),

       new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
             RaisedButton(
              onPressed: () {
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
              print('no change');
            }
              },
            child: Text('Update Photo Database'),
           ),

            RaisedButton(
              onPressed: () {
                print('update user settings DB');
                appData.currentUser.processSelectedUserSettings().then((id){
                  print('done'); 
                });
              },
            child: Text('Update User Settings'),
           ),
*/
           RaisedButton(
              onPressed: () {
  
              print('***** Print parameters *****');
              appData.currentUser.printPhotosParameters();
//              appData.currentUser.processPhotosSelected();
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
                print(ImageUtil.IsNetworkImage(null));
                print(ImageUtil.IsFileImage(null));
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
