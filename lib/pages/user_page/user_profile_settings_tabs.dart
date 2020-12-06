

import 'package:flutter/material.dart';
import './user_profile_photo_page.dart';

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

    final List<Image> argimages = ModalRoute.of(context).settings.arguments;



      return MaterialApp(
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
             onPressed:() => Navigator.pop(context, false),
            )
          ),
          body: 
          PageStorage(
          bucket: bucket,
          child:
          TabBarView(
            children: [
              UserProfilePhotoPage(argimages),
              //Icon(Icons.directions_walk),
              Icon(Icons.access_alarm),
              
            ],
          )),
          

        ),
      ),
    );
  }

}