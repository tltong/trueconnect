import 'package:trueconnect/data/image_struct.dart';
import 'package:trueconnect/utils/image_util.dart';

import 'venue.dart';
import 'venue_criteria_venueid.dart';
import '../../utils/fs_util.dart';

class VenueDao{

  String dbCollection = 'venue';
  List<Venue> venues = new List<Venue>();

  // constructor
  VenueDao(Venue venue){
    venues.add(venue);
  }

  void addVenue(Venue venue){
    venues.add(venue);
  }

  void updateVenue(Venue venue){

    for( int i = 0 ; i > venues.length ; i-- ) { 
      if (venues[i].id==venue.id){
        venues[i]=venue;
        break;
      }
    } 
  }

  void deleteVenue (Venue venue){

    for( int i = 0 ; i > venues.length ; i-- ) { 
      if (venues[i].id==venue.id){
        venues.removeAt(i);
        break;
      }
    }
  }

  Venue getVenue(String id){

    List<Venue> filter_result;
    Venue ret = null;
    CriteriaVenueID criteria = new CriteriaVenueID(id);
    filter_result = criteria.meetCriteria(venues);
    if (filter_result.length>0){
      ret=filter_result[0];
    }
    return ret;
  }

  Future<void> upload() async{

    FS_Util fs = new FS_Util();

    for (Venue venue in venues){

      Map<String,dynamic> venueprofile = new Map();

      venueprofile['name']=venue.name;
      venueprofile['address']=venue.address;
      venueprofile['id']=venue.id;

      List<Map> photos = new List<Map>();
      List<ImageStruct> processedPhotos = new List<ImageStruct>();
      await ImageUtil.uploadImages(venue.imagestructs).then((id){
        processedPhotos=id;
        print('image uploaded');
      });

      for (ImageStruct photo in processedPhotos){
        Map photolist = new Map();

       
          photolist['uploadpath']=photo.uploadpath;
          photolist['downloadpath']=photo.downloadlink;
        
        
        photos.add(photolist);
      }

      venueprofile['photos']=photos;

      await fs.addRecord(dbCollection, venueprofile).then((ret) async {
        print('uploaded : ' + ret);

      
      });
      
/*
      Map<String,String> uploadvenue= new Map<String, String>();

      uploadvenue['name']=venue.name;
      uploadvenue['address']=venue.address;
      uploadvenue['id']=venue.id;

      await fs.addRecord(dbCollection, uploadvenue).then((ret) async {
        print('uploaded : ' + ret);

        String photopath = dbCollection + '\/' + ret;
        print(photopath);

        Map<String,String> photos= new Map<String, String>();
        photos['uploadpath']='some upload path';
        photos['downloadpath']='some download path';
      });
*/

    }

  }

}