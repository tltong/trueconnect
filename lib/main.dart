import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:trueconnect/user.dart';
import 'package:trueconnect/create_user.dart';
import 'package:trueconnect/view_user.dart';
import 'package:trueconnect/pages/user_profile/user_profile.dart';
import 'package:trueconnect/pages/testpage.dart';

import 'package:trueconnect/utils/fs_util.dart';
import 'package:trueconnect/utils/image_util.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> implements AddUserCallback {
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();
 
  final databaseReference = Firestore.instance;
  Future<File> imageFile;
  File sampleImage;
  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _currentAddress;

  _loginWithFB() async{

    
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }

  _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

@override
  void initState() {
    super.initState();

  }

@override
  void dispose() {
    super.dispose();
 
  }

@override // Call util method for add user information
  void addUser(User user) {
    setState(() {
      
    });
  }

 pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0, width: 300.0),
        ],
      ),
    );
  }


Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

_getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

_getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
   
    // TODO: implement build
     
    return ChangeNotifierProvider<User>(

       create: (context) => User(),
       child: 
    MaterialApp(
    routes: {
      '/createuser': (context) => CreateUser(),
      '/viewuser': (context) => ViewUser(),
      '/userprofile': (context) => UserProfile(),
      '/testpage': (context) => TestPage(),
    },
   title: 'Project Pimp',
      home: new Scaffold(
          body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/jap.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          new Center(
                     child: _isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
		                  Image.network(userProfile["picture"]["data"]["url"], height: 50.0, width: 50.0,),
                      Text(userProfile["name"]),
                      OutlineButton( child: Text("Logout"), onPressed: (){
                        _logout();
                      },)
                    ],
                  )
                : Center(
                    child: OutlineButton(
                      child: Text("Login with Facebook"),
                      onPressed: () {
                        _loginWithFB();
                      },
                    ),
                  )
          ),

          new Center(
              child: Column(children: <Widget>[
                  
  Builder(
        builder: (context) => 
        RaisedButton(
              onPressed: () {

                Navigator.pushNamed(context,'/userprofile');


              },
              child: Text('User profile'),
            ),
        ),
 Builder(
        builder: (context) => 
        RaisedButton(
              onPressed: () {

                Navigator.pushNamed(context,'/testpage');
             },
              child: Text('Test stateful page'),
            ),
            ),

 
        RaisedButton(
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
             },
              child: Text('Select Image'),
            ),
            

      showImage(),
     RaisedButton(
              onPressed: () {
                  FS_Util fs = new FS_Util();
                  fs.uploadFile('member/image',sampleImage).then((id){
                    print('uploading complete : ' + id);
                  });
             },
              child: Text('Upload Image 2'),
            ),

    RaisedButton(
              onPressed: () {
                
                  ImageUtil.pickImageFromGallery().then((image){
                   
                    setState(() {
                    sampleImage = image;
                    }); 
                  }
                  );
             },
              child: Text('Select Image2'),
            ),
   sampleImage == null ? Text('Select image #2') : enableUpload(),

  Builder(
        builder: (context) => 
        RaisedButton(
              onPressed: () {
               
                
                FS_Util fs = new FS_Util();
                
                Map<String,String> bookList= new Map<String, String>();
                bookList['Title'] = "Kane and Abel";
                bookList['author'] = "Jeffrey Archer";
                bookList['Rating'] = "Five star";
                fs.addRecord('newbooks', bookList).then((id){
                  Map<String,String> bookListUpdate= new Map<String, String>();
                  bookListUpdate['ID'] = id;
                  fs.updateRecord('newbooks', id, bookListUpdate);
                  }
                );
                          
                
                
                         
             },
              child: Text('Test Firebase'),
            ),
      ),
      RaisedButton(
              onPressed: () {
                _getCurrentLocation();
             },
              child: Text('Get location'),
            ),
       _currentPosition != null?Text(_currentAddress):Text('Location'),

      RaisedButton(
              onPressed: () {
                
                FS_Util fs = new FS_Util();
                fs.queryDoc('newbooks','author','Jeffrey Archer').then((doc){
                  if (doc!=null){
                  print(doc.length);
                  print(doc[0]['Title']);
                  }
                });
             },
              child: Text('Database read'),
            ),
              ],)
          )

        ],
      )),
     ));
   }
}


