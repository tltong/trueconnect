import 'package:flutter/material.dart';
import 'package:trueconnect/pages/user_profile/user_settings_tabs.dart';
import '../../utils/appdata.dart';
import '../../utils/fs_util.dart';
import './user_photos.dart';
import './edit_user_settings.dart';

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
    //print('dispose from user profile');
    //print('state change in photo page : ' + UserSettingsTabsState.statechange.toString());
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
       new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
             RaisedButton(
              onPressed: () {
              
            
            if (UserPhotosPageState.changed==true)
            
            {
               print('update database');
              appData.currentUser.processSelectedPhotos().then((id){
             //   print('profile photo index : ' + appData.currentUser.profilePhotoIndex.toString());
                appData.currentUser.updateUserDB();
                print('database updated');
                UserPhotosPageState.changed=false;
                UserPhotosPageState.profileIndex=appData.currentUser.profilePhotoIndex;
              });
          }
             else{
              print('no change');
            }

                 

              },
            child: Text('Update Database'),
           ),

           RaisedButton(
              onPressed: () {
              
        //      print('Change :  ' + UserPhotosPageState.changed.toString());
        //      print('Profile photo :  ' + UserPhotosPageState.profileIndex.toString());
         //     var userdetails = EditUseSettingsPageState.ExtractUserSettings();
        //      print (userdetails);
                print(appData.currentUser.selectedUserSettings);
             
     
              },
            child: Text('Print parameters'),
           ),

          ],
        )
      ),
    
        );
    
  }


}
