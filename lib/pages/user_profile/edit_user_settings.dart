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

  static String country,city;




@override
  void initState() {
    
    super.initState();
    countryctrl.text=country;
    cityctrl.text=city;
  }

@override
  void dispose() {
    super.dispose();
 
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
        child: Column(
          children: <Widget>[

          // start of formbuilder

              


          FormBuilder(
//  key: _fbKey,
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
                        country = loc.country;
                        city = loc.city;
                        
                        countryctrl.text=country;
                        cityctrl.text=city;
                    
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

      
    ],
  ),
),
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







          // end of formbuilde


          ],

         
        ) // Column
      ),  // Center
   
      
    );  // Scaffold
  }
  
} 