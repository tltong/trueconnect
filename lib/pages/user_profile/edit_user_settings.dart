import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import '../../utils/location_util.dart';
import 'package:intl/intl.dart';

class EditUseSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditUseSettingsPageState();
  }
}

class EditUseSettingsPageState extends State<EditUseSettingsPage>{

  var countryctrl = TextEditingController();
  var cityctrl = TextEditingController();
  var dobctrl = TextEditingController();
  var aboutctrl = TextEditingController();
  var heightctrl = TextEditingController();
  var occupationctrl = TextEditingController();
  var mobilectrl = TextEditingController();

  static String country,city,gender;
  BoxConstraints bx = new BoxConstraints();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  DateTime dob;

String parsedob(String inDob)
{
  var parseStr = inDob.split('-');
  return parseStr[2]+'-'+parseStr[1]+'-'+parseStr[0];
  
}


@override
  void initState() {

    countryctrl.text=appData.currentUser.country;
    cityctrl.text=appData.currentUser.city;
    aboutctrl.text=appData.currentUser.about;
    heightctrl.text=appData.currentUser.height;
    occupationctrl.text=appData.currentUser.occupation;
    mobilectrl.text=appData.currentUser.mobile;

    super.initState();
 
  }

@override
  void dispose() {

    
    if (dobctrl.text.toString().isNotEmpty){
      appData.currentUser.dob = DateTime.tryParse(parsedob(dobctrl.text));
      
    }
    
    dobctrl.dispose();
    
    
    super.dispose();

 //   _fbKey.currentState.save();
 
  }

 @override
  Widget build(BuildContext context) {

 return Scaffold(
   /*
      appBar: AppBar(
        title: Text("Test page"),
      ),
    */
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
  key: _fbKey,
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
                        //country = loc.country;
                        //city = loc.city;
                        
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
                      controller: countryctrl,
                      onChanged: (value) => (appData.currentUser.country=value),
                      
                    ),
        
                     FormBuilderTextField(
                      attribute: 'city',
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Current City"),
                      controller: cityctrl,
                      onChanged: (value) => (appData.currentUser.city=value),
                    ),

                      FormBuilderDateTimePicker(
                //      key: _fbKey,
                      initialValue: appData.currentUser.dob,
                     // firstDate: DateTime.tryParse('1990-01-01'),
                     // lastDate: DateTime.tryParse('2000-01-01'),
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Date of Birth"),
                      controller: dobctrl
                    ),
                        FormBuilderDropdown(
                      attribute: "gender",
                      initialValue: appData.currentUser.gender,
                      onChanged: (value) => (appData.currentUser.gender=value),
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
                      controller:aboutctrl,
                      onChanged: (value) => (appData.currentUser.about=value),
                    ),

                    FormBuilderTextField(
                      attribute: "height",
                      decoration: InputDecoration(labelText: "Height (cm)"),
                      keyboardType: TextInputType.number,
                      controller:heightctrl,
                      onChanged: (value) => (appData.currentUser.height=value),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(100),
                        FormBuilderValidators.max(200),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: 'occupation',
                      initialValue: appData.currentUser.occupation,
                      decoration: InputDecoration(labelText: "Occupation"),
                      controller:occupationctrl,
                      onChanged: (value) => (appData.currentUser.occupation=value),
                    ),
                    FormBuilderDropdown(
                      attribute: "education",
                      decoration: InputDecoration(labelText: "Education"),
                      onChanged: (value) => (appData.currentUser.education=value),
                      initialValue: appData.currentUser.education,
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
                      controller:mobilectrl,
                      onChanged: (value) => (appData.currentUser.mobile=value),
                    ),

      
    ],
  ),  // Column
),
/*
Row(
  children: <Widget>[
    Expanded(
      child: MaterialButton(
        color: Theme.of(context).accentColor,
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          _fbKey.currentState.save();
          
          print(_fbKey.currentState.value);
/*
          _fbKey.currentState.save();
          if (_fbKey.currentState.validate()) {
            print(_fbKey.currentState.value);
          } else {
            print("validation failed");
          }
  */      
        },
      ),
    ),
    SizedBox(
      width: 20,
    ),
    Expanded(
      child: MaterialButton(
        color: Theme.of(context).accentColor,
        child: Text(
          "Reset",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
 //         _fbKey.currentState.reset();
        },
      ),
    ),
  ],
)

*/
          // end of formbuilder


          ],

         
        ) // Column
        
          )) ),  // Center
   
      
    );  // Scaffold
  }
  
} 