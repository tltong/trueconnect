import 'venue.dart';
import 'venue_criteria_venueid.dart';

class VenueDao{

  List<Venue> venues = new List<Venue>();

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

  

}