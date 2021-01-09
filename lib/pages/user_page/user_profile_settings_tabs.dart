

import 'package:flutter/material.dart';
import 'package:trueconnect/utils/misc_util.dart';
import './user_profile_photo_page.dart';
import './user_profile_edit_settings_page.dart';
import '../../data/user/userdata.dart';

class UserProfileSettingsTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return  UserProfileSettingsTabsState();
  }

}



class UserProfileSettingsTabsState extends State<UserProfileSettingsTabs>  {


  final PageStorageBucket bucket = PageStorageBucket();


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


    final UserData argUserData = ModalRoute.of(context).settings.arguments;
    final List<Image> argimages = argUserData.images;
    
    print('user profile settings tabs : edit settings page created');
    
    print('user profile settings tabs : userdata id ' + argUserData.id);
    
    
    

      return 
      WillPopScope(
      
      
         onWillPop: () async {
          print('user profile settings tabs : willpopscope');
          
           Navigator.pop(context, false);
          //return true;
        },

      child:  MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                new Text("PHOTOS"),
                new Text("DETAILS"),
              ],
            ),
            title: Text('My Profile'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() async { 

                String str = 'RETURN VALUE!';
                Map map = new Map();
                map["id"] = argUserData.id;
                map["name"] = UserProfileEditSettingsPage.userData.name;
                map["country"] = UserProfileEditSettingsPage.userData.country;
                map["city"] = UserProfileEditSettingsPage.userData.city;
                map["dobstring"] = UserProfileEditSettingsPage.userData.dobstring;
                map["gender"] = UserProfileEditSettingsPage.userData.gender;
                map["height"] = UserProfileEditSettingsPage.userData.height;
                map["occupation"] = UserProfileEditSettingsPage.userData.occupation;
                map["education"] = UserProfileEditSettingsPage.userData.education;
                map["about"] = UserProfileEditSettingsPage.userData.about;
              
                UserData ret = new UserData(map);


                print ('user profile settings tabs : back arrow');                
                if (UserProfileEditSettingsPage.userData.dobstring!=null){
                  print ('user profile settings tabs : dobstring :'+UserProfileEditSettingsPage.userData.dobstring);                
                  DateTime dt = DateTime.parse(UserProfileEditSettingsPage.userData.dobstring);
                  print('user profile settings tabs : datetime - year ' + dt.year.toString());
                  int age = UserProfileEditSettingsPage.userData.getAge();
                  
                  print('user profile settings tabs : age ' + age.toString());
           
                }

                Navigator.pop(context, ret);
             },
            
            )
          ),
          body: 
          PageStorage(
          bucket: bucket,
          child:
          TabBarView(
            children: [
              UserProfilePhotoPage(argimages),
              UserProfileEditSettingsPage(argUserData),
              //Icon(Icons.directions_walk),
//              Icon(Icons.access_alarm),
            ],
          )),
          

          ),
        ),
      )
      );

      


  }

}