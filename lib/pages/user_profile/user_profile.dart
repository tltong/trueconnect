import 'package:flutter/material.dart';
import 'package:trueconnect/pages/user_profile/user_settings_tabs.dart';
import '../../utils/appdata.dart';
import '../../utils/fs_util.dart';

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
            
                print('uploading start');
              
               appData.currentUser.uploadImages().then((id){
                print('uploading done');   
                
               appData.currentUser.updateUserDB().then((id){
                print('userprofile update done');   });
                

              });
              
                 

              },
            child: Text('Update Database'),
           ),

          ],
        )
      ),
    
        );
    
  }


}
