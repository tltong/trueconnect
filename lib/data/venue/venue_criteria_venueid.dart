import 'venue_criteria.dart';
import 'venue.dart';

class CriteriaVenueID implements VenueCriteria {

  String VenueID;

  CriteriaVenueID (String id){
    VenueID = id;
  }

  @override
  List<Venue> meetCriteria(List<Venue> venues) {

    List<Venue> ret = new List<Venue>();

    for (Venue venue in venues){
        if (venue.id==VenueID){
          ret.add(venue);
        }
    }
    return ret;
  }
}