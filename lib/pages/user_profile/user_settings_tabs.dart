import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trueconnect/utils/image_util.dart';
import '../../user.dart';
import 'get_location_page.dart';
import 'dart:io';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trueconnect/utils/appdata.dart';
import '../../utils/location_util.dart';
import 'edit_user_settings.dart';

enum photoSelection { Gallery, Facebook }

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

    countryctrl = TextEditingController();
    cityctrl = TextEditingController();
    super.initState();

  }

@override
  void dispose() {

    countryctrl.dispose();
    cityctrl.dispose();
    super.dispose();
 
  }

  File image1,image2,image3,image4,image5,image6,image7,image8,image9;
  bool image1profile=false,image2profile=false,image3profile=false;
  
  var countryctrl;
  var cityctrl;

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
              PhotoGrid(context),
              EditUseSettingsPage(),
              //UserDetails(),
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
                      attribute: 'name',
                      initialValue: appData.currentUser.name,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                     Builder(
        builder: (context) => 
        Stack(
        children: <Widget>[
            
            Align(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
              onPressed: () {
                     
                    setState((){ 
                    LocationUtil loc = new LocationUtil();
                     loc.getLocation().then((ret){
                          countryctrl.text=loc.country;
                        cityctrl.text=loc.city;
                    
                     });
                      });
       
              },
              child: Text('Get Location'),
            ),
            )
         ] ,
        ),
       ),
      
                    FormBuilderTextField(
                      attribute: 'country',
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Current Country"),
                      controller: countryctrl
                      
                    ),
        
                     FormBuilderTextField(
                      attribute: 'city',
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Current City"),
                      controller: cityctrl
                    ),
                    
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Date of Birth"),
                    ),
                     /*
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
                  */
                    
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
                      attribute: 'aboutme',
                      decoration: InputDecoration(labelText: "About me"),
                      keyboardType: TextInputType.multiline,
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
                      initialValue: appData.currentUser.email,
                      enabled:false,
                      readOnly: true,
                      validators: [FormBuilderValidators.email()],
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  
       
                  

                    FormBuilderTextField(
                      attribute: 'mobile',
                      decoration: InputDecoration(labelText: "Mobile"),
                      keyboardType: TextInputType.phone,
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

Widget getLocationPage()
{
return Scaffold(
      appBar: AppBar(
        title: Text("Test page"),
      ),

      body: 
       new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
             RaisedButton(
              onPressed: () {
              
              },
            child: Text('Go back!'),
           ),

          ],
        )
      ),
   
      
    );


}

void clearprofilestates()
{
  image1profile = image2profile = image3profile = false;



}

Future<photoSelection> _asyncSimpleDialog(BuildContext context, int imageindex) async {
  
  return await showDialog<photoSelection>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Photo options'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                clearprofilestates();
                setState(() {          
                
                switch(imageindex) {
                  case 1:
                    image1profile=true;
                    break;
                  case 2:
                    image2profile=true;
                    break;
                }
                
                }); 
                Navigator.pop(context);
              },
              child: const Text('Make profile photo'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState((){ 

                   switch(imageindex) {

                    case 1:
                    image1profile=false;
                    image1=null;
                    break;

                   case 2:
                    image2profile=false;
                    image2=null;
                    break;


                   }


                  });
              
              Navigator.pop(context); 
              },
              child: const Text('Remove photo'),
            ),
            SimpleDialogOption(
              onPressed: () {
                ImageUtil.pickImageFromGallery().then((retimage){
              if (retimage!=null)
                setState((){ 
                  
                   switch(imageindex) {
                   case 1: 
                      image1profile=false;
                      image1=retimage;
                      break;

                   case 2:
                      image2profile=false;
                      image2=retimage;
                      break;
                  
                   }
                  
                  });
              });
              Navigator.pop(context); 
              },
              child: const Text('Choose new photo'),
            ),
            
          ],
        );
      });
}


Container photoItem(File inImage, bool profilePic){

  
  if (inImage == null){

    return new Container(
            child: Image.asset('images/addphoto.png'),
            
            );
  }
  else {

    if (profilePic==false){
     return new Container(
            child: Image.file(inImage),
            
            );
    }else{
      return new Container(
        decoration: new BoxDecoration(
          border: new Border.all(
            color: Colors.green,
            width: 3.0,
            style: BorderStyle.solid
          ),
          image: new DecorationImage(
              image: new FileImage(inImage),
          )
        ));
    }
  }
}


Widget PhotoGrid(BuildContext context) {
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
            photoItem(null,false):
            image1profile==true?photoItem(image1,true):photoItem(image1,false),
            onTap: () {
              if (image1==null){
                ImageUtil.pickImageFromGallery().then((retimage){
              if (retimage!=null)
                setState((){ image1=retimage;});
              });
              }else{
              _asyncSimpleDialog(context,1);
              }
            },
            ),
            GestureDetector(
            child: image2==null?
            photoItem(null,false):
            image2profile==true?photoItem(image2,true):photoItem(image2,false),
            onTap: () {
              if (image2==null){
                ImageUtil.pickImageFromGallery().then((retimage){
              if (retimage!=null)
                setState((){ image2=retimage;});
              });
              }else{
              _asyncSimpleDialog(context,2);
              }
            },
            ),


/*
          GestureDetector(
            child: image1==null?
            Image.asset('images/addphoto.png'):
            Image.file(image1),
            onTap: () {
              if (image1==null){
                ImageUtil.pickImageFromGallery().then((retimage){
              if (retimage!=null)
                setState((){ image1=retimage;});
              });
              }else{
              _asyncSimpleDialog1(context);
              }
            },
            ),
            
            GestureDetector(
            child: 
            new Container(
        decoration: new BoxDecoration(
          border: new Border.all(
            color: Colors.green,
            width: 3.0,
            style: BorderStyle.solid
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.green,
              offset: new Offset(5.0, 5.0),
              blurRadius: 5.0,
            )
          ],
          image: new DecorationImage(
              image: new AssetImage('images/addphoto.png'),
          )
        )),
            
            onTap: () {
              
            },
            ),

*/
          
        ],
      ),
    )
    
    
    );
}
}