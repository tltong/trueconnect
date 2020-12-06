import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/appdata.dart';
import '../../utils/location_util.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditUseSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditUseSettingsPageState();
  }
}

class EditUseSettingsPageState extends State<EditUseSettingsPage>{

  TextEditingController namectrl = TextEditingController();
  var countryctrl = TextEditingController();
  var cityctrl = TextEditingController();
  var dobctrl = TextEditingController();
  String genderString;
  var aboutctrl = TextEditingController();
  var heightctrl = TextEditingController();
  var occupationctrl = TextEditingController();
  String educationString;
  var mobilectrl = TextEditingController();

  String country,city,dobstring;
  BoxConstraints bx = new BoxConstraints();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  DateTime dob;

  


@override
  void initState() {

    namectrl.text=appData.currentUser.selectedUserSettings["name"];
    countryctrl.text=appData.currentUser.selectedUserSettings["country"];
    cityctrl.text=appData.currentUser.selectedUserSettings["city"];
    dobctrl.text=appData.currentUser.selectedUserSettings["dob"];
    genderString=appData.currentUser.selectedUserSettings["gender"];
    aboutctrl.text=appData.currentUser.selectedUserSettings["aboutme"];
    heightctrl.text=appData.currentUser.selectedUserSettings["height"];
    occupationctrl.text=appData.currentUser.selectedUserSettings["occupation"];
    educationString=appData.currentUser.selectedUserSettings["education"];
    mobilectrl.text=appData.currentUser.selectedUserSettings["mobile"];
/*
    countryctrl.text=appData.currentUser.country;
    cityctrl.text=appData.currentUser.city;
    aboutctrl.text=appData.currentUser.about;
    heightctrl.text=appData.currentUser.height;
    occupationctrl.text=appData.currentUser.occupation;
    mobilectrl.text=appData.currentUser.mobile;
  //  print('at init dob : ' + appData.currentUser.dob.toString());
  
  */
    super.initState();
 
  }

void updateUserDetailsGender(String genderin){
  genderString=genderin;
  updateUserDetails();
}

void updateUserDetailsEducation(String educationin){
  educationString=educationin;
  updateUserDetails();
}

void updateUserDetailsDOB(String dobin){
  dobctrl.text=dobin;
  updateUserDetails();
}

void updateUserDetails(){
  print('update user details - ' + ' dob : ' + dobctrl.text);

 appData.currentUser.selectedUserSettings.clear();
    appData.currentUser.selectedUserSettings.putIfAbsent("name", ()=> namectrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("country", ()=> countryctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("city", ()=> cityctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("dob", ()=> dobctrl.text);
    
    
    appData.currentUser.selectedUserSettings.putIfAbsent("gender", ()=> genderString);
    appData.currentUser.selectedUserSettings.putIfAbsent("aboutme", ()=> aboutctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("height", ()=> heightctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("occupation", ()=> occupationctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("education", ()=> educationString);
     appData.currentUser.selectedUserSettings.putIfAbsent("mobile", ()=> mobilectrl.text);

}

@override
  void dispose() {
    print('edit user page dispose');

    updateUserDetails();

    /*
    appData.currentUser.selectedUserSettings.clear();
    appData.currentUser.selectedUserSettings.putIfAbsent("name", ()=> namectrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("country", ()=> countryctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("city", ()=> cityctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("dob", ()=> dobctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("gender", ()=> genderString);
    appData.currentUser.selectedUserSettings.putIfAbsent("aboutme", ()=> aboutctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("height", ()=> heightctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("occupation", ()=> occupationctrl.text);
    appData.currentUser.selectedUserSettings.putIfAbsent("education", ()=> educationString);
     appData.currentUser.selectedUserSettings.putIfAbsent("mobile", ()=> mobilectrl.text);
  */
  //print(appData.currentUser.selectedUserSettings);
  
   // print(appData.currentUser.selectedUserSettings);
  /*  
    if (dobctrl.text.toString().isNotEmpty){
      appData.currentUser.dob = DateTime.tryParse(parsedob(dobctrl.text));
    }
*/
/*
    print(appData.currentUser.name);
    print(appData.currentUser.country);
    print(appData.currentUser.city);
    print('at dispose dob : ' + dobctrl.text.toString());
 //   print('at dispose dob : ' + appData.currentUser.dob.toString());
    print(appData.currentUser.education);
    print(appData.currentUser.mobile);
    
    dobctrl.dispose();
  */  
    
    super.dispose();

 //   _fbKey.currentState.save();
 
  }


 @override
  Widget build(BuildContext context) {
    print('edit user page build');

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
            onChanged: (value) => ( updateUserDetails()),
  key: _fbKey,
 autovalidateMode: AutovalidateMode.always,
  child: Column(
    children: <Widget>[
        
         FormBuilderTextField(
                      attribute: 'name',
                      initialValue: namectrl.text,
                      enabled:false,
                      readOnly: true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Name"),
                      controller: namectrl
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
                      initialValue: countryctrl.text,
              //        onChanged: (value) => (appData.currentUser.country=value),
                      
                    ),
        
                     FormBuilderTextField(
                      attribute: 'city',
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Current City"),
                      controller: cityctrl,
                      initialValue: cityctrl.text,
               //       onChanged: (value) => (appData.currentUser.city=value),
                    ),
                      FormBuilderDateTimePicker(
                        onChanged: (value) => (    updateUserDetailsDOB(value.toString()) ),
                       initialValue:dobctrl.text.length>0?DateTime.tryParse(dobctrl.text):null,
                       initialDate:dobctrl.text.length>0?DateTime.tryParse(dobctrl.text):DateTime(1990,01,01),
//                      initialDate:appData.currentUser.dob==null?DateTime(1990,01,01):
 //                     DateTime.parse(appData.currentUser.dob.toString()),
  //                    initialValue:appData.currentUser.dob==null?DateTime(1990,01,01):
  //                    DateTime.parse(appData.currentUser.dob.toString()),
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(labelText: "Date of Birth"),
                      controller: dobctrl
                    ),

                    
                        FormBuilderDropdown(
                      attribute: "gender",
                      initialValue: genderString,
                      onChanged: (value) => (updateUserDetailsGender(value)),
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
                      initialValue: aboutctrl.text,
                      decoration: InputDecoration(labelText: "About me"),
                      keyboardType: TextInputType.multiline,
                      controller:aboutctrl,
               //       onChanged: (value) => (aboutctrl.text=value),
                    ),
  
                    FormBuilderTextField(
                      attribute: "height",
                      initialValue: heightctrl.text,
                      decoration: InputDecoration(labelText: "Height (cm)"),
                      keyboardType: TextInputType.number,
                      controller:heightctrl,
//                      onChanged: (value) => (heightctrl.text=value),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(100),
                        FormBuilderValidators.max(200),
                      ],
                    ),
                    
                    
                    FormBuilderTextField(
                      attribute: 'occupation',
                      initialValue: occupationctrl.text,
                      decoration: InputDecoration(labelText: "Occupation"),
                      controller:occupationctrl,
              //        onChanged: (value) => (appData.currentUser.occupation=value),
                    ),
                    
                    FormBuilderDropdown(
                      attribute: "education",
                      decoration: InputDecoration(labelText: "Education"),
                      onChanged: (value) => (  updateUserDetailsEducation(value)),
                      initialValue: educationString,
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
                      initialValue: mobilectrl.text,
                      decoration: InputDecoration(labelText: "Mobile"),
                      keyboardType: TextInputType.phone,
                      controller:mobilectrl,
                 //     onChanged: (value) => (mobilectrl.text=value),
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
        
          )
          ) 
          ),  // Center
   
      
    );  // Scaffold
  }
  
} 