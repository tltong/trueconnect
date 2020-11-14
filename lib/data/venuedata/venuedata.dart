import 'package:flutter/material.dart';
import '../../utils/misc_util.dart';
import '../../data/image_struct.dart';

class VenueData{

  static String VENUE_STATUS_PUBLISHED = "venue_status_published";
  static String VENUE_STATUS_CONFIRMED = "venue_status_confirmed";
  static String VENUE_STATUS_DRAFT = "venue_status_draft";

  static final String VENUE_HOST_PAY = 'I will pay';
  static final String VENUE_DATE_PAY = 'I want my date to pay';
  static final String VENUE_GO_DUTCH = 'Go dutch';


  List<Image> images;
  List<ImageStruct> imagestructs;

  List<String> applicants;      // contains appplicants' user IDs
  Map<String,String> applicant_comments = new Map<String,String>();


  String name;
  String address;
  String type;
  String splurge;
  String pay;

  String notes;

  DateTime startTime;
  DateTime endTime;

  String userName;
  String userID;
  String ID;


  String confirmedApplicant;  
  String status;

  VenueData(List<Image> inImages, 
            String inUserName,
            String inUserID,
            DateTime inStartTime,
            DateTime inEndTime,
            inName, 
            inAddress, 
            inType, 
            inSplurge, 
            inPay,
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
    pay=inPay;
    notes=inNotes;

    ID = MiscUtil.GenerateRandomString(12);

    applicants = new List<String>();
  }

  addApplicant (String applicantID){
    if (applicants.contains(applicantID)==false){
        applicants.add(applicantID);
    }
  }

  addApplicantComment(String applicantID, String comment){
    applicant_comments.remove(applicantID);
    applicant_comments.putIfAbsent(applicantID, () => comment);
  }

  removeApplicantComment(String applicantID){
    applicant_comments.remove(applicantID);
  }

  removeApplicant(String applicantID){
    if(applicants.contains(applicantID)){
      applicants.remove(applicantID);
    }
  }

  setConfirmedApplicant(String applicantID){
    confirmedApplicant=applicantID;
  }

  cancelConfirmation(){
    confirmedApplicant=null;
  }
  
  setConfirmedStatus(){
    status=VENUE_STATUS_CONFIRMED;
  }

  setPublishedStatus(){
    status=VENUE_STATUS_PUBLISHED;
  }

  setDraftStatus(){
    status=VENUE_STATUS_DRAFT;
  }

}