import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import 'package:intl/intl.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../utils/appdata.dart';
import '../../user.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

String startTimeString;

String endTimeString;

String venueName;

String venueAddress;

String activityType;

String splurge;

String notes;


class VenueSettingsDetails extends StatefulWidget {

  static String retVenueName;
  static String retVenueAddress;
  static String retActivity;
  static String retSplurge;
  static String retNotes;
  
  static DateTime retStartDateTime;
  static DateTime retEndDateTime;
  
  VenueSettingsDetails(
  String inHostName,
  String inUserID,
  DateTime inStartTime,
  DateTime inEndTime,

  String inName, 
  String inAddress, 
  String inType, 
  String inSplurge, 
  String inNotes  
  ){

    //  print('venue settings details : ' + inStartTime.toString());
      retStartDateTime=inStartTime;
      if(retStartDateTime!=null){
        startTimeString='${retStartDateTime.day}-${retStartDateTime.month}-${retStartDateTime.year}  ${retStartDateTime.hour}:${retStartDateTime.minute}';
      }
      else
        startTimeString='Not set';

      retEndDateTime=inEndTime;
      if(retEndDateTime!=null){
        endTimeString='${retEndDateTime.day}-${retEndDateTime.month}-${retEndDateTime.year}  ${retEndDateTime.hour}:${retEndDateTime.minute}';
      }
      else
        endTimeString='Not set';


      retVenueName=inName;
      venueName=inName;
  
      retVenueAddress=inAddress;
      venueAddress=inAddress;

      activityType = inType;
      retActivity = inType;

      splurge = inSplurge;
      retSplurge = inSplurge;

      retNotes = inNotes;
      notes = inNotes;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VenueSettingsDetailsState();
  }
}

class VenueSettingsDetailsState extends State<VenueSettingsDetails>{

  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  BoxConstraints bx = new BoxConstraints();

 String _startdate = startTimeString;


 String _enddate = endTimeString;


@override
  void initState() {
    super.initState();
  }

@override
  void dispose() {

    super.dispose();
}

  @override
  Widget build(BuildContext context) {
  
    return 

  Scaffold(

      body: 
       new Center(
  
         child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: bx.minHeight,
            ),
        child: Column(
          children: <Widget>[
          // start of formbuilder

              FormBuilder(
            // onChanged: (value) => ( ),
              key: _fbKey,
              autovalidate: true,
              child: Column(
            children: <Widget>[

    RaisedButton(
          
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
          
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2020, 1, 1),
                      maxTime: DateTime(2050, 12, 31), 
                      onConfirm: (date) {
               //     print('confirm $date');
                    _startdate = '${date.day}-${date.month}-${date.year}  ${date.hour}:${date.minute}';
                    VenueSettingsDetails.retStartDateTime = date;
                   
                    setState(() {});
                  }
                  //,currentTime: DateTime.now(), locale: LocaleType.en
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Start Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  
                                  " $_startdate",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),

   
  RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2020, 1, 1),
                      maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
                //    print('confirm $date');
                    _enddate = '${date.day}-${date.month}-${date.year}  ${date.hour}:${date.minute}';
                    VenueSettingsDetails.retEndDateTime=date;
                    setState(() {});
                  }
                  //, currentTime: DateTime.now(), locale: LocaleType.en
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "End Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  " $_enddate",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),

              FormBuilderTextField(
                      attribute: 'name',
                      initialValue: venueName,
                    onChanged: (value) => (VenueSettingsDetails.retVenueName = value),
                      enabled:true,
                     // readOnly: true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Venue Name"),
                   //   controller: namectrl
                    ),

              FormBuilderTextField(
                      attribute: 'address',
                      initialValue: venueAddress,
                    onChanged: (value) => (VenueSettingsDetails.retVenueAddress = value),
                      enabled:true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Address"),
                   //   controller: addressctrl
                    ),


             FormBuilderDropdown(
                      attribute: "activity",
                      decoration: InputDecoration(labelText: "Actvity type"),
                      onChanged: (value) => (  VenueSettingsDetails.retActivity = value),
                      initialValue: activityType,
                       items: ['Meal', 'Drinks', 'Outdoors', 'Nightlife','Sports','Getaway','Others']
                          .map((activity) => DropdownMenuItem(
                          value: activity, child: Text("$activity")))
                          .toList(),
                    ),

            FormBuilderDropdown(
                      attribute: "splurge",
                      decoration: InputDecoration(labelText: "Splurge"),
                      onChanged: (value) => (  VenueSettingsDetails.retSplurge = value),
                      initialValue: splurge,
                       items: ['\$', '\$\$', '\$\$\$',]
                          .map((splurge) => DropdownMenuItem(
                          value: splurge, child: Text("$splurge")))
                          .toList(),
                    ),

              FormBuilderTextField(
                      attribute: 'Notes',
                      onChanged: (value) => (  VenueSettingsDetails.retNotes = value),
                      initialValue: notes,
                      enabled:true,
//                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Why go on this date?"),
                   //   controller: notesctrl
                    ),


      ]
  )
          )
          ]
        )  ) ) )

 );
}
}