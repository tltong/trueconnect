import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trueconnect/utils/image_util.dart';
import 'dart:io';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:geolocator/geolocator.dart';


class UserSettingsTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserSettingsTabsState();
  }
}

class UserSettingsTabsState extends State<UserSettingsTabs>  {

@override
  void initState() {
    super.initState();

  }

@override
  void dispose() {
    super.dispose();
 
  }

  File image1,image2,image3,image4,image5,image6,image7,image8,image9;
  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                new Text("PHOTOS"),
                new Text("DETAILS"),
                new Text("PREFERENCES"),
              ],
            ),
            title: Text('My Profile'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
             onPressed:() => Navigator.pop(context, false),
            )
          ),
          body: 
          PageStorage(
          bucket: bucket,
          child:
          TabBarView(
            children: [
              PhotoGrid(),
              UserDetails(),
              Icon(Icons.directions_bike),
              
            ],
          )),
          

        ),
      ),
    );
  }


Widget _gridList() {
    return GridView.builder(
      itemCount: 9,
      
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            
      itemBuilder: (context, index) {
        
        return Padding(
          padding: const EdgeInsets.all(3.0),
          
            child: GestureDetector(
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://firebasestorage.googleapis.com/v0/b/trueconnection-702ad.appspot.com/o/icons%2Faddphoto.png?alt=media&token=48c5f154-8219-4b8f-88db-419ab1d16a1b'),
            onTap: () {
              ImageUtil.pickImageFromGallery();
            },
          ),
          
        );
   
      },
     );
  }


 Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
             width: 50.0,
            height: 50.0,
            ),
            Text(country.name),
       ],
        
      ));

Widget UserDetails() {
  return Scaffold(
        body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                initialValue: {
                  'date': DateTime.now(),
                  'accept_terms': false,
                },
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: 'text',
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                    
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Date of Birth"),
                    ),
                     
                      Container (
                        
                        child: 
                        
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          Text(
                          'Location',
                          textAlign: TextAlign.left,
                          style: TextStyle(height: 5, fontSize: 10)),
                          
                          CountryPickerDropdown(
                      initialValue: 'tr',
                      itemBuilder: _buildDropdownItem,
                      onValuePicked: (Country country) {
                        print("${country.name}");
                        },
                      ),
                      ],)
                      ),
          
                    
                     FormBuilderDropdown(
                      attribute: "gender",
                      decoration: InputDecoration(labelText: "Gender"),
                      // initialValue: 'Male',
                      hint: Text('Select Gender'),
                      validators: [FormBuilderValidators.required()],
                      items: ['Male', 'Female']
                          .map((gender) => DropdownMenuItem(
                          value: gender, child: Text("$gender")))
                          .toList(),
                    ),
                    FormBuilderTextField(
                      attribute: "height",
                      decoration: InputDecoration(labelText: "Height (cm)"),
                      keyboardType: TextInputType.number,
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(100),
                        FormBuilderValidators.max(200),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: 'occupation',
                      decoration: InputDecoration(labelText: "Occupation"),
                    ),
                    FormBuilderDropdown(
                      attribute: "education",
                      decoration: InputDecoration(labelText: "Education"),
                      // initialValue: 'Male',
                       items: ['High School', 'College', 'University', 'Master', 'PhD']
                          .map((education) => DropdownMenuItem(
                          value: education, child: Text("$education")))
                          .toList(),
                    ),
                    FormBuilderTextField(
                      attribute: 'email',
                      validators: [FormBuilderValidators.email()],
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    FormBuilderTextField(
                      attribute: 'mobile',
                      decoration: InputDecoration(labelText: "Mobile"),
                      keyboardType: TextInputType.phone,
                    ),
                    FormBuilderTextField(
                      attribute: 'aboutme',
                      decoration: InputDecoration(labelText: "About me"),
                      keyboardType: TextInputType.multiline,
                    ),
                    
                  ]
                )
              )
            ],
          )
        )
        )
    );

}


Widget PhotoGrid() {
   return  Scaffold(
     
      body: 
      
      PageStorage(  
      bucket: bucket,  
      child:
      GridView.count(
        crossAxisCount: 4,
        children: <Widget>[
          GestureDetector(
            child: image1==null?
            Image.asset('images/addphoto.png'):
            Image.file(image1),
            onTap: () {
              ImageUtil.pickImageFromGallery().then((retimage){
              if (retimage!=null)
                setState((){ image1=retimage;});
              }); }, ),
        ],
      ),
    )
    
    
    );
}
}