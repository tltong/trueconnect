import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trueconnect/utils/misc_util.dart';
import './../../data/user/userdata.dart';
import 'package:carousel_slider/carousel_options.dart';
import './user_profile_settings_tabs.dart';


class UserProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserProfilePageState();
  }
}


class UserProfilePageState extends State<UserProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Image> argImages;


  @override
  Widget build(BuildContext context) {

    BoxConstraints bx = new BoxConstraints();

    final UserData arg = ModalRoute.of(context).settings.arguments;
    argImages=arg.images;

    List<Image> images;
    var namectrl = TextEditingController();
    var countryctrl = TextEditingController();
    var cityctrl = TextEditingController();
    var agectrl = TextEditingController();
    var genderctrl = TextEditingController();
    var aboutctrl = TextEditingController();
    var occupationctrl = TextEditingController();
    var educationctrl = TextEditingController();
    var heightctrl = TextEditingController();

    namectrl.text=arg.name;
    countryctrl.text=arg.country;
    cityctrl.text=arg.city;

    if (arg.getAge()!=null){
      agectrl.text=arg.getAge().toString();
    }
    genderctrl.text=arg.gender;
    aboutctrl.text=arg.about;
    occupationctrl.text=arg.occupation;
    educationctrl.text=arg.education;
    heightctrl.text=arg.height;

    if(arg.images==null){
      images = new List<Image>();
      images.add(Image.asset('images/no-image.png'));
    }else{
      images= arg.images;
    }


       
  final List<Widget> imageSliders = images.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          item,
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
             
            ),
          ),
        ],
      )
    ),
  ),
)).toList();


 return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () async {


        UserData ret = await 
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfileSettingsTabs(),
        settings: RouteSettings(
              arguments: arg,
            ),
        
        ),

        );
    
    
//        print ('user profile page : return value from user_profile_settings_tabs : name ' + ret.name);
//        print ('user profile page : return value from user_profile_settings_tabs : country ' + ret.country);
//        print ('user profile page : return value from user_profile_settings_tabs : education ' + ret.city);
 //       print ('user profile page : return value from user_profile_settings_tabs : age ' + ret.getAge().toString());
  

        namectrl.text = ret.name;
        countryctrl.text = ret.country;
        cityctrl.text=ret.city;

        if (ret.getAge()!=null){
          agectrl.text=ret.getAge().toString();
        }
        
        genderctrl.text=ret.gender;
        heightctrl.text=ret.height;
        occupationctrl.text=ret.occupation;
        educationctrl.text=ret.education;
        aboutctrl.text=ret.about;


      },
      child: const Icon(Icons.edit),
    ),
    
    body: 

    ListView(
    children:
    [
        CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
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
                labelText: 'City'
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
              controller: aboutctrl,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'About me'
              ),
            ),















          ])))),


    ])
    
    
 );






  }


}