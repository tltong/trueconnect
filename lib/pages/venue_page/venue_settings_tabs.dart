import 'package:flutter/material.dart';
import 'venue_settings_photos.dart';
import 'venue_settings_details.dart';
import '../../data/venuedata/venuedata.dart';

List<Image> images;
VenueSettingsPhotos vPhotos;
VenueSettingsDetails vDetails;

class VenueSettingsTabs extends StatefulWidget {

VenueSettingsTabs(VenueData inVenueData){
  images = inVenueData.images;

  vPhotos = new VenueSettingsPhotos(images);

  vDetails = new VenueSettingsDetails(
  inVenueData.userName,
  inVenueData.userID,
  inVenueData.startTime,
  inVenueData.endTime,
  inVenueData.name,
  inVenueData.address,
  inVenueData.type,
  inVenueData.splurge,
  inVenueData.notes);

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
              VenueData retVenueData = new VenueData(VenueSettingsPhotos.vPhotos,
                                                    'TL',
                                                    '003',
                                                     DateTime.now(),
                                                     DateTime.now(), 
                                                     VenueSettingsDetails.retVenueName, 
                                                     VenueSettingsDetails.retVenueAddress,
                                                     VenueSettingsDetails.retActivity,
                                                     VenueSettingsDetails.retSplurge,
                                                     VenueSettingsDetails.retNotes);
          //    print('venue_settings_tabs page : start time : ' + VenueSettingsDetails.retStartDateTime.toString());
          //    print('venue_settings_tabs page : end time : ' + VenueSettingsDetails.retEndDateTime.toString());
   
              Navigator.pop(context,retVenueData);
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
              vDetails
  //            Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    )

  );



 }  // build
}
