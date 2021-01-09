import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:trueconnect/utils/location_util.dart';
import '../../data/user/userdata.dart';
import 'package:intl/intl.dart';

class UserProfileEditSettingsPage extends StatefulWidget {

  static UserData userData;

  UserProfileEditSettingsPage(UserData inUserData){
    userData = inUserData;
    if (userData.education!=null){
      print('user profile edit settings page : education string : ' + userData.education.toString());
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserProfileEditSettingsPageState();
   }
}

class UserProfileEditSettingsPageState extends State<UserProfileEditSettingsPage> {

  BoxConstraints bx = new BoxConstraints();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  TextEditingController countryctrl = TextEditingController();
  TextEditingController cityctrl = TextEditingController();

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

    countryctrl.text = UserProfileEditSettingsPage.userData.country;
    cityctrl.text = UserProfileEditSettingsPage.userData.city;

    return Scaffold(

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
              autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: <Widget>[

                    FormBuilderTextField(
                      attribute: 'name',
                      initialValue: UserProfileEditSettingsPage.userData.name,
                      enabled:false,
                      readOnly: true,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Name"),
                    ),

                    FormBuilderDropdown(
                      attribute: "gender",
                      initialValue: UserProfileEditSettingsPage.userData.gender,
                      onChanged: (value) => (UserProfileEditSettingsPage.userData.gender=value),
                      decoration: InputDecoration(labelText: "Gender"),
                      hint: Text('Select Gender'),
                      //validators: [FormBuilderValidators.required()],
                      items: ['Male', 'Female']
                          .map((gender) => DropdownMenuItem(
                          value: gender, child: Text("$gender")))
                          .toList(),
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
                                        UserProfileEditSettingsPage.userData.country = loc.country;
                                        
                                        cityctrl.text=loc.city;
                                        UserProfileEditSettingsPage.userData.city = loc.city;
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
                      //validators: [FormBuilderValidators.required()],
                      onChanged: (value) => (UserProfileEditSettingsPage.userData.country=value),
                      decoration: InputDecoration(labelText: "Current Country"),
                      controller: countryctrl,
                    ),
      
 
                    FormBuilderTextField(
                      attribute: 'city',
                      //validators: [FormBuilderValidators.required()],
                      onChanged: (value) => (UserProfileEditSettingsPage.userData.city=value),
                      decoration: InputDecoration(labelText: "Current City"),
                      controller: cityctrl,
                    ),

                    FormBuilderDateTimePicker(
                      onChanged: (value) => ( UserProfileEditSettingsPage.userData.dobstring = value.toString() ),
                      initialValue:UserProfileEditSettingsPage.userData.dobstring!=null?DateTime.tryParse(UserProfileEditSettingsPage.userData.dobstring):null,
                      initialDate:DateTime(1990,01,01),
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(labelText: "Date of Birth"),
                    ),

                   FormBuilderTextField(
                      attribute: "height",
                      initialValue: UserProfileEditSettingsPage.userData.height,
                      decoration: InputDecoration(labelText: "Height (cm)"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => (UserProfileEditSettingsPage.userData.height=value),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(100),
                        FormBuilderValidators.max(200),
                      ],
                    ),

                    FormBuilderTextField(
                      attribute: 'occupation',
                      initialValue: UserProfileEditSettingsPage.userData.occupation,
                      decoration: InputDecoration(labelText: "Occupation"),
                      onChanged: (value) => (UserProfileEditSettingsPage.userData.occupation=value),
                    ),
                    
                    FormBuilderDropdown(
                      attribute: "education",
                      decoration: InputDecoration(labelText: "Education"),
                      onChanged: (value) => (  UserProfileEditSettingsPage.userData.education=value),
                      initialValue: UserProfileEditSettingsPage.userData.education,
                       items: ['High School', 'College', 'University', 'Master', 'PhD']
                          .map((education) => DropdownMenuItem(
                          value: education, child: Text("$education")))
                          .toList(),
                    ),

                    FormBuilderTextField(
                      attribute: 'aboutme',
                      initialValue: UserProfileEditSettingsPage.userData.about,
                      decoration: InputDecoration(labelText: "About me"),
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) => (UserProfileEditSettingsPage.userData.about=value),
                    ),

                  ]
                )
            )
          ]
        )
          ))));

  }

}