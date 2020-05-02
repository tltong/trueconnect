import 'venue.dart';
import '../../utils/appdata.dart';
import '../image_struct.dart';
import 'package:flutter/material.dart'; 
import 'package:random_string/random_string.dart';

class VenueFactory{

  static Venue CreateVenue(List<ImageStruct> imagestructs, String name, String address, String description, Type type, int splurge){

    String userid = appData.currentUser.id;
    String id = randomString(10);

    Venue ret = new Venue(imagestructs,name,address,description,type,splurge,userid,id);
    return ret;
  }



}