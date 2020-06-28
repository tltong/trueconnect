
import 'package:flutter/material.dart';
import 'venue_settings_photos.dart';
//import '../user_profile/user_photo_page.dart';
//import 'venue_settings_photos_backup.dart';


List<Image> images;
VenueSettingsPhotos vPhotos;

class VenueSettingsTabs extends StatefulWidget {

VenueSettingsTabs(List<Image> inImages){

  images = inImages;
  vPhotos = new VenueSettingsPhotos(inImages);
}

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VenueSettingsTabsState();
  }

}


class VenueSettingsTabsState extends State<VenueSettingsTabs>  {

final PageStorageBucket bucket = PageStorageBucket();

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

  MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: 
        
        Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                new Text("PHOTOS"),
                new Text("DETAILS"),
              ],
            ),
            title: Text('Venue'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
             onPressed:() async{  
          //     print('venue_settings_tabs : returning vPhotos length : ' + VenueSettingsPhotos.vPhotos.length.toString());
               Navigator.pop(context,VenueSettingsPhotos.vPhotos);
               },
           
           
            )
          ),
          body: 
          PageStorage(
          bucket: bucket,
          child:
          TabBarView(
            children: [
              vPhotos,
              Icon(Icons.directions_bike),
              
            ],
          ),
        ),
      ),
    )

  )
 
  ;



 }
}




