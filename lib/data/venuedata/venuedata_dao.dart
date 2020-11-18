import 'package:flutter/material.dart';
import 'venuedata.dart';
import '../../utils/fs_util.dart';
import '../../utils/image_util.dart';
import 'dart:io';
import '../../data/image_struct.dart';
import '../../utils/misc_util.dart';

class VenueDataDao {

  static String VENUE_STORATE_LOCATION = 'venuephotos/';
  static String VENUE_COLLECTION = 'venues';

  int count;
  int index;
  List<VenueData> lVenueData;

  VenueDataDao(){
  //  count = inCount;
    index=0;
    lVenueData = new List<VenueData>();

  }

  retrieveCount(){
    return lVenueData.length;
  }

  initialiseWithData(List<VenueData> inlVenueData){ 
    lVenueData=inlVenueData;
    count=lVenueData.length;
  }

  List<VenueData> retrieveVenueData (int retrieveCount){

  //  print ('venuedata_dao : index before : ' + index.toString());
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

 //   print ('venuedata_dao : index after : ' + index.toString());

    return retVenueDataList;
  }

  resetIndex(){
    index=0;
  }

  // won't fill in downloadlink
  List<ImageStruct> constructImageStructs(List<Image> inImages){
      
    List<ImageStruct> retImageStruct = new List<ImageStruct>();

    for (int i=0;i<inImages.length;i++){
      String rand = MiscUtil.GenerateRandomString(12);
      String uploadpath = VENUE_STORATE_LOCATION+rand.toString();

      ImageStruct imagestruct = new ImageStruct(inImages[i],uploadpath,null);
      retImageStruct.add(imagestruct);
    }

    return retImageStruct;



  }

  Future<List<VenueData>> getVenueData() async {



    FS_Util fs = new FS_Util();

    print('*** venudata_dao first query ***');
    await fs.paginateQueryDoc(VENUE_COLLECTION,'userName','Tai-Loong Tong','name',2).then((doc){

        for (int i=0;i<doc.length;i++){
           print( doc[i].toString());
        }


      }
      );
    print('\n\n');
    print('*** venudata_dao next query ***');

    await fs.paginateQueryDocNext(VENUE_COLLECTION,'userName','Tai-Loong Tong','name',2).then((doc){

        for (int i=0;i<doc.length;i++){
           print( doc[i].toString());
        }

      }
      );

  }

  Future<String> uploadRecord(int index){

    FS_Util fs = new FS_Util();

    Map<String, dynamic> venue_upload = new Map<String, dynamic>();

    VenueData venue = lVenueData[index];

    DateTime startTime = venue.startTime;
    DateTime endTime = venue.endTime;
    String userName = venue.userName;
    String userID = venue.userID;
    String name = venue.name;
    String address = venue.address;
    String type = venue.type;
    String splurge = venue.splurge;
    String pay = venue.pay;
    String notes = venue.notes;
    String ID = venue.ID;
    String confirmedApplicant = venue.confirmedApplicant;
    String status = venue.status;

    List<String> applicants = new List<String>();
    applicants = venue.applicants;
    Map<String,String> applicant_comments = new Map<String,String>();
    applicant_comments = venue.applicant_comments;

    venue_upload.putIfAbsent("startTime", ()=> startTime);
    venue_upload.putIfAbsent("endTime", ()=> endTime);
    venue_upload.putIfAbsent("userName", ()=> userName);
    venue_upload.putIfAbsent("userID", ()=> userID);
    venue_upload.putIfAbsent("name", ()=> name);
    venue_upload.putIfAbsent("address", ()=> address);
    venue_upload.putIfAbsent("type", ()=> type);
    venue_upload.putIfAbsent("splurge", ()=> splurge);
    venue_upload.putIfAbsent("pay", ()=> pay);
    venue_upload.putIfAbsent("notes", ()=> notes);
    venue_upload.putIfAbsent("ID", ()=> ID);
    venue_upload.putIfAbsent("confirmedApplicant", ()=> confirmedApplicant);
    venue_upload.putIfAbsent("status", ()=> status);
    venue_upload.putIfAbsent("applicants", ()=> applicants);
    venue_upload.putIfAbsent("applicant_comments", ()=> applicant_comments);

    List<ImageStruct> retImageStruct = constructImageStructs(lVenueData[index].images);

    ImageUtil.uploadImages(retImageStruct).then((ret){
      lVenueData[index].imagestructs=ret;
/*
      print ('venuedata_dao : number of imagestructs ' + lVenueData[index].imagestructs.length.toString());
      for (int i=0;i<lVenueData[index].imagestructs.length;i++){
        print ('venuedata_dao : imagestruct # ' + i.toString());
          print ('venuedata_dao : ' + lVenueData[index].imagestructs[i].uploadpath);
          print ('venuedata_dao : ' + lVenueData[index].imagestructs[i].downloadlink);
      }
*/
      List<String> uploadpaths = new List<String>();
      List<String> downloadlinks = new List<String>();
      for (int i=0;i<lVenueData[index].imagestructs.length;i++){
        uploadpaths.add(lVenueData[index].imagestructs[i].uploadpath);
        downloadlinks.add(lVenueData[index].imagestructs[i].downloadlink);
      }

      venue_upload.putIfAbsent("uploadpaths", ()=> uploadpaths);
      venue_upload.putIfAbsent("downloadlinks", ()=> downloadlinks);

      fs.addRecord(FS_Util.VENUE_COLLECTION, venue_upload).then((id){
      return id;
    });



    });


  }



}