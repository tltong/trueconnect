import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import 'package:intl/intl.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../utils/appdata.dart';
import '../../user.dart';

TextEditingController namectrl;
String venueName;

TextEditingController addressctrl;
String venueAddress;

String activityType;

String splurge;

TextEditingController notesctrl;
String notes;

class VenueSettingsDetails extends StatefulWidget {


  static String retVenueName;
  static String retVenueAddress;
  static String retActivity;
  static String retSplurge;
  static String retNotes;
  

  VenueSettingsDetails(String inName, String inAddress, String inType, String inSplurge, String inNotes  ){

      namectrl = new TextEditingController();
      namectrl.text=inName;
      retVenueName=inName;

      addressctrl = new TextEditingController();
      addressctrl.text=inAddress;
      retVenueAddress=inAddress;

      activityType = inType;
      retActivity = inType;

      splurge = inSplurge;
      retSplurge = inSplurge;

      notesctrl = new TextEditingController();
      notesctrl.text = inNotes;
      retNotes = inNotes;

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


@override
  void initState() {
    super.initState();
  }

@override
  void dispose() {

    //print('venue_settings_details_page : ' + namectrl.text.toString());

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

              FormBuilderTextField(
                      attribute: 'name',
                      initialValue: namectrl.text,
                    onChanged: (value) => (VenueSettingsDetails.retVenueName = value),
                      enabled:true,
                     // readOnly: true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Venue Name"),
                      controller: namectrl
                    ),

              FormBuilderTextField(
                      attribute: 'address',
                      initialValue: namectrl.text,
                    onChanged: (value) => (VenueSettingsDetails.retVenueAddress = value),
                      enabled:true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Address"),
                      controller: addressctrl
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
                      initialValue: notesctrl.text,
                      enabled:true,
//                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Notes"),
                      controller: notesctrl
                    ),


      ]
  )
          )
          ]
        )  ) ) )

 );
}
}