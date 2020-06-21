import 'venue.dart';
import '../../utils/appdata.dart';
import 'package:flutter/material.dart'; 
import '../../data/imageobject/image_mediator.dart';
import '../../utils/misc_util.dart';

class VenueFactory{

  static Venue CreateVenue(ImageMediator inImgMediator, String name, String address, String description, Type type, int splurge){

    String userid = appData.currentUser.id;
    String id = MiscUtil.GenerateRandomString(15);

    Venue ret = new Venue(inImgMediator,name,address,description,type,splurge,userid,id);
    return ret;
  }



}
