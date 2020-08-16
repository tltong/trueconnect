import 'package:flutter/material.dart';
import 'venuedata.dart';

class VenueDataDao {

  int count;
  int index;
  List<VenueData> lVenueData;

  VenueDataDao(int inCount){
    count = inCount;
    index=0;
    lVenueData = new List<VenueData>();

  }

  retrieveCount(){
    return count;
  }

  initialiseWithData(List<VenueData> inlVenueData){ 
    lVenueData=inlVenueData;
    count=lVenueData.length;
  }

  List<VenueData> retrieveVenueData (int retrieveCount){

    List<VenueData> retVenueDataList = new List<VenueData>();
    int orgIndex = index;
    int j=0;

    for (int i=0;i<retrieveCount;i++){
      if ((orgIndex+i)<count){
        retVenueDataList.add(lVenueData[orgIndex+i]);
        j++;
      }
    }
    index=index+j;

    return retVenueDataList;
  }

  resetIndex(){
    index=0;
  }



}