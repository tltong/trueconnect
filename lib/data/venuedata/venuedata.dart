import 'package:flutter/material.dart';


class VenueData{

  List<Image> images;

  String name;
  String address;
  String type;
  String splurge;
  String notes;

  VenueData(List<Image> inImages, inName, inAddress, inType, inSplurge, inNotes){

  
    images=inImages;
    name=inName;
    address=inAddress;
    type=inType;
    splurge=inSplurge;
    notes=inNotes;
  }


}