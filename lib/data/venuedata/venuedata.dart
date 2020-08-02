import 'package:flutter/material.dart';


class VenueData{

  List<Image> images;

  String name;
  String address;
  String type;
  String splurge;
  String notes;

  DateTime startTime;
  DateTime endTime;

  String userName;
  String userID;
  

  VenueData(List<Image> inImages, 
            String inUserName,
            String inUserID,
            DateTime inStartTime,
            DateTime inEndTime,
            inName, 
            inAddress, 
            inType, 
            inSplurge, 
            inNotes)
  {
    startTime=inStartTime;
    endTime=inEndTime;
    images=inImages;
    userName=inUserName;
    userID=inUserID;

    name=inName;
    address=inAddress;
    type=inType;
    splurge=inSplurge;
    notes=inNotes;
  }


}