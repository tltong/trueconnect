
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
/*
    print('VenueSettingsTabs init : ');
    for (int i=0;i<images.length;i++){
      print(images[i].toString());
    }
*/
    super.initState();
  }

@override
  void dispose() {
    print('Vphotos number : ' + VenueSettingsPhotos.vPhotos.length.toString());
    for (int i=0;i<VenueSettingsPhotos.vPhotos.length;i++){
      print(VenueSettingsPhotos.vPhotos[i]);
    }

    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return MaterialApp(
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
             onPressed:() => Navigator.pop(context, false),
            )
          ),
          body: 
          PageStorage(
          bucket: bucket,
          child:
          TabBarView(
            children: [
              //VenueSettingsPhotos(images),
              vPhotos,
              Icon(Icons.directions_bike),
              
            ],
          ),
        ),
      ),

        

    ));


 }
}




