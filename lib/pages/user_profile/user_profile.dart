import 'package:flutter/material.dart';
import 'package:trueconnect/pages/user_profile/user_settings_tabs.dart';
import '../../utils/appdata.dart';
import '../../utils/fs_util.dart';
import './user_photos.dart';
import './edit_user_settings.dart';
import '../../utils/image_util.dart';
import '../../user.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {

Photos photos;
List<Image> images;
List child;
BuildContext contextcopy;
Map<String,String> userDetails;

String name,country,city,age;

var namectrl = TextEditingController();
var countryctrl = TextEditingController();
var cityctrl = TextEditingController();
var agectrl = TextEditingController();

var genderctrl = TextEditingController();
var aboutctrl = TextEditingController();
var heightctrl = TextEditingController();

var occupationctrl = TextEditingController();
var educationctrl = TextEditingController();
var mobilectrl = TextEditingController();


BoxConstraints bx = new BoxConstraints();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
 // print('images length in map :' + list.length.toString());
//  print('images in map' + list.toString());
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  //  print('map');
  //  print(i.toString());
  }
 
  return result;
}

final Widget placeholder = Container(color: Colors.grey);



Widget _Dialog(BuildContext context, Image displayImage) {
    return new AlertDialog(
      //title: const Text('About Pop up'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          displayImage,
          //Image.asset('images/addphoto.png'),
          
        ],
      )
     
    );
}

void initialiseUserDetails(){


    
  
  userDetails = appData.currentUser.selectedUserSettings;
  print('initialise user details from profile page : ' + userDetails.toString());
  
  namectrl.text = userDetails["name"];
  countryctrl.text = userDetails["country"];
  cityctrl.text = userDetails["city"];

  String dobstring = userDetails["dob"];

  if (dobstring!=null)
    {
        if (dobstring.length>0)
          age = (appData.currentUser.getAge(dobstring)).toString();
        else
             age = 'Not specified';
    }
  else{
   age = 'Not specified';
  }  
  agectrl.text=age;
  
  genderctrl.text=appData.currentUser.selectedUserSettings["gender"];
  aboutctrl.text=appData.currentUser.selectedUserSettings["aboutme"];
  heightctrl.text=appData.currentUser.selectedUserSettings["height"] + 'cm';
  occupationctrl.text=appData.currentUser.selectedUserSettings["occupation"];
  educationctrl.text=appData.currentUser.selectedUserSettings["education"];
  mobilectrl.text=appData.currentUser.selectedUserSettings["mobile"];

 
}


void initialiseChild(){

print('initialise child');
//print(images);
//print(photos.profilePhotoIndex);
//print(images.length);

List<Image> imageslocal;
imageslocal=images;
if (imageslocal.length==0) imageslocal.add(Image.asset('images/no-image.png'));


child = map<Widget>(
  images,
  (index, i) {
    return 
    GestureDetector(
       onTap: () {
              showDialog(
            context: contextcopy,
            builder: (BuildContext contextcopy) => _Dialog(contextcopy,i),
          );

            },
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
            i,
           // Image.asset('images/addphoto.png'),
           // Image.network(i, fit: BoxFit.scaleDown, width: 1000.0),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              
            ),
          ),
        ]),
      ),
    )


    

    );
    
  },
).toList();

}

@override
  void initState() {

    print('***** user profile page init *****');
    photos = appData.currentUser.getPhotos();
     images = appData.currentUser.photos.getSelectedPhotos();
  //   print(images);
     initialiseChild();
     initialiseUserDetails();
    super.initState();

  }

@override
  void dispose() {

    print('***** user profile page dispose *****');

    if (appData.currentUser.UserSettingsChanged()==true){

      appData.currentUser.processSelectedUserSettings().then((id){
        print('database updated');
        });
    }else{
    //  print('no change to user details');
    }

    if (appData.currentUser.photosChanged()==true) 
      appData.currentUser.processPhotosSelected();
  


  if (UserPhotosPageState.changed==true)
            {
               print('update database');
              appData.currentUser.processSelectedPhotos().then((id){
             //   print('profile photo index : ' + appData.currentUser.profilePhotoIndex.toString());
                appData.currentUser.updateUserDB();
                print('database updated');
                appData.currentUser.initialiseUserPhotos();
//                UserPhotosPageState.profileIndex=appData.currentUser.profilePhotoIndex;
              });
          }
             else{
     //         print('no change to user photos');
            }


    super.dispose();
 
  }

  @override
  Widget build(BuildContext context) {
    print('***** user profile page build *****');
     contextcopy=context;
    photos = appData.currentUser.getPhotos();
     images = appData.currentUser.photos.getSelectedPhotos();
    initialiseChild();
    initialiseUserDetails();
  //  print('image length : '+ images.length.toString());
   // profileimage=images.length<1?Image.asset('images/no-image.png'):images[0];
    
    //appData.currentUser.photos.printPhotosParameters();
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserSettingsTabs()),
        );
      },
      child: const Icon(Icons.edit),
    ),
    
    body: 

    ListView(
    children:
    [

 new CarouselSlider(//                      controller: namectrl

      items: child,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    ),

 new Center(
           child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: bx.minHeight,
            ),

        child: Column(
          children: <Widget>[

TextField(
  controller: namectrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Name'
  ),
),

TextField(
  controller: countryctrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Country'
  ),
),

TextField(
  controller: cityctrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Country'
  ),
),

TextField(
  controller: agectrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Age'
  ),
),

TextField(
  controller: genderctrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Gender'
  ),
),
       
TextField(
  controller: aboutctrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'About me'
  ),
),

TextField(
  controller: heightctrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Height'
  ),
),

TextField(
  controller: occupationctrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Occupation'
  ),
),
       
TextField(
  controller: educationctrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Education'
  ),
),

TextField(
  controller: mobilectrl,
  readOnly: true,
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'Mobile'
  ),
),

         ],
         ) 
                )
          ) 
          ), 




       new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
           RaisedButton(
              onPressed: () {
  
              print('***** Print parameters *****');
              print('central user settings : '+ appData.currentUser.selectedUserSettings.toString());
              print('page user settings : '+ userDetails.toString());

              },
            child: Text('Print parameters'),
           ),

                   RaisedButton(
              onPressed: () {
                appData.currentUser.processPhotosSelected();
              },
            child: Text('Process photos'),
           ),

            RaisedButton(
             onPressed: () {
                print(appData.currentUser.photosChanged());
               },
            child: Text('Test stuff'),
           ),

          ],
        )
      ),
    


    ]),

        );
    
  }


}
