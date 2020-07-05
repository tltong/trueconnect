import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import 'package:intl/intl.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../utils/appdata.dart';
import '../../user.dart';

class VenueSettingsDetails extends StatefulWidget {


  VenueSettingsDetails(){

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
  TextEditingController namectrl = TextEditingController();
  TextEditingController addressctrl = TextEditingController();
  TextEditingController notesctrl = TextEditingController();
  


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

              FormBuilderTextField(
                      attribute: 'name',
                    //  initialValue: namectrl.text,
                      enabled:true,
                     // readOnly: true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Venue Name"),
                      controller: namectrl
                    ),

              FormBuilderTextField(
                      attribute: 'address',
                    //  initialValue: namectrl.text,
                      enabled:true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Address"),
                      controller: addressctrl
                    ),


             FormBuilderDropdown(
                      attribute: "activity",
                      decoration: InputDecoration(labelText: "Actvity type"),
            //          onChanged: (value) => (  updateUserDetailsEducation(value)),
               //       initialValue: educationString,
                       items: ['Meal', 'Drinks', 'Outdoors', 'Nightlife','Sports','Getaway','Others']
                          .map((activity) => DropdownMenuItem(
                          value: activity, child: Text("$activity")))
                          .toList(),
                    ),
            FormBuilderDropdown(
                      attribute: "splurge",
                      decoration: InputDecoration(labelText: "Splurge"),
               //       initialValue: educationString,
                       items: ['\$', '\$\$', '\$\$\$',]
                          .map((splurge) => DropdownMenuItem(
                          value: splurge, child: Text("$splurge")))
                          .toList(),
                    ),

              FormBuilderTextField(
                      attribute: 'Notes',
                    //  initialValue: namectrl.text,
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