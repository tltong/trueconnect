
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../data/venue/venue.dart';
import '../../data/venue/venue_factory.dart';
import '../../data/imageobject/image_mediator.dart';
import './venue_settings_tabs.dart';
import './venue_settings_photos.dart';
import '../../data/venuedata/venuedata.dart';
import '../../data/venuedata/venuedata_dao.dart';



class VenuePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VenuePageState();
  }
  
}

class VenuePageState extends State<VenuePage>{

ImageMediator pgImgMediator;
List child;

TextEditingController datectrl = new TextEditingController();
TextEditingController hostctrl = new TextEditingController();
TextEditingController namectrl = new TextEditingController();
TextEditingController addressctrl = new TextEditingController();
TextEditingController typectrl = new TextEditingController();
TextEditingController splurgectrl = new TextEditingController();
TextEditingController payctrl = new TextEditingController();
TextEditingController notesctrl = new TextEditingController();


// return values
List<Image> images;
List<Image> retImage;

String retVenueName;
String retVenueAddress;
String retVenueType;
String retVenueSplurge;
String retVenuePay;
String retVenueNotes;

DateTime retStartDateTime;
DateTime retEndDateTime;
String retUserName;
String retUserID;

@override
  void initState() {
//    print('venue_page : initstate');
    super.initState();
  }

@override
  void dispose() {
 //   print('venue_page : dispose');
     super.dispose();
   }

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

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

List _initialiseChild(BuildContext context, List<Image> inImages){

//print('venue_page : initialiseChild');

//if (retImage!=null)
//print('venue_page : retImage length at start of initialiseChild: ' + retImage.length.toString());

List<Image> imageslocal = new List<Image>();


//if (retImage!=null)
//print('venue_page : retImage length in the 1st middle part of initialiseChild: ' + retImage.length.toString());


for (int i=0;i<inImages.length;i++){
  imageslocal.add(inImages[i]);
}
//print('venue_page : initialiseChild; imageslocal length : ' + imageslocal.length.toString());
//imageslocal=inImages;


if (imageslocal.length==0) imageslocal.add(Image.asset('images/no-image.png'));


//if (retImage!=null)
//print('venue_page : retImage length in the 2nd middle part of initialiseChild: ' + retImage.length.toString());


List child = map<Widget>(
  imageslocal,
  (index, i) {
    return 
    GestureDetector(
       onTap: () {
              showDialog(
            context: context,
            builder: (BuildContext contextcopy) => _Dialog(contextcopy,i),
          );

            },
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
            i,
  

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

//if (retImage!=null)
//print('venue_page : retImage length at end of initialiseChild: ' + retImage.length.toString());

//print('venue_page : initialiseChild; this.child length : '+child.length.toString());

return child;

}

@override
  Widget build(BuildContext context) {

    VenueData argVenueData = ModalRoute.of(context).settings.arguments;
     List<Image> argImages = argVenueData.images;

    if (retVenueName==null)
      retVenueName = argVenueData.name;
    
    if (retVenueAddress==null)
      retVenueAddress=argVenueData.address;

    if (retVenueType==null)
      retVenueType=argVenueData.type;

    if (retVenueSplurge==null)
      retVenueSplurge=argVenueData.splurge;

    if (retVenuePay==null)
      retVenuePay=argVenueData.pay;

    if (retVenueNotes==null)
      retVenueNotes=argVenueData.notes;

    if (retStartDateTime==null)
      retStartDateTime=argVenueData.startTime;

    if (retEndDateTime==null)
      retEndDateTime=argVenueData.endTime;

    if (retUserName==null)
      retUserName=argVenueData.userName;

    if (retUserID==null)
      retUserID=argVenueData.userID;

 
    var DayOfWeek = new List(8);
    DayOfWeek[0]='None';
    DayOfWeek[1]='Mon';
    DayOfWeek[2]='Tues';
    DayOfWeek[3]='Wed';
    DayOfWeek[4]='Thurs';
    DayOfWeek[5]='Fri';
    DayOfWeek[6]='Sat';
    DayOfWeek[7]='Sun';


    String dateString =
    
    retStartDateTime.day.toString()+'-'+retStartDateTime.month.toString()+'-'+retStartDateTime.year.toString()
    + " (" + DayOfWeek[retStartDateTime.weekday] + ") " + 
    
    retStartDateTime.hour.toString()+':'+ retStartDateTime.minute.toString()
    + ' - ';

    dateString += retEndDateTime.day.toString() 
    +'-'+retEndDateTime.month.toString()+'-'+retEndDateTime.year.toString()
    + " (" + DayOfWeek[retEndDateTime.weekday] + ") "
     +   retEndDateTime.hour.toString()+':'+ retEndDateTime.minute.toString();

    datectrl.text=dateString;
    hostctrl.text=retUserName;
    namectrl.text=retVenueName;
    addressctrl.text=retVenueAddress;
    typectrl.text=retVenueType;
    splurgectrl.text=retVenueSplurge;
    payctrl.text=retVenuePay;
    notesctrl.text=retVenueNotes;

      List<Image> inImages;

      if (retImage==null){
 
        inImages = argImages;
        retImage = argImages;
      }else{
        inImages=retImage;
      }
    if (this.child==null){
      

      List images=_initialiseChild(context, inImages);
      this.child=images;
    }
   
  return 
        
   WillPopScope(
    onWillPop: () async {
    
        VenueData retVenueData = new VenueData(retImage,
         retUserName,
        retUserID,
        retStartDateTime,
        retEndDateTime,
        retVenueName,
        retVenueAddress,
        retVenueType,
        retVenueSplurge,
        retVenuePay,
        retVenueNotes);

          Navigator.pop(context, retVenueData);
          return false;
        },
    child: 
     
     new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Venue",
          style: new TextStyle(color: Colors.white),
        ),
      ),
       floatingActionButton: FloatingActionButton(
      onPressed: () async {
          
      VenueData venuedata = new VenueData(inImages,
          retUserName,
        retUserID,
        retStartDateTime,
        retEndDateTime,
      retVenueName, 
      retVenueAddress, 
      retVenueType, 
      retVenueSplurge, 
      retVenuePay,
      retVenueNotes);
      
      VenueData retVenueData;

      retVenueData = await
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VenueSettingsTabs(venuedata)),
        );

         inImages=retVenueData.images;
        retImage=retVenueData.images;

  setState(() {

    this.child=_initialiseChild(context, retImage);
  
    retVenueName = retVenueData.name;
    retVenueAddress = retVenueData.address;

    retStartDateTime = retVenueData.startTime;

    retEndDateTime = retVenueData.endTime;

    retVenueType = retVenueData.type;
    retVenueSplurge = retVenueData.splurge;
    retVenuePay = retVenueData.pay;
    retVenueNotes = retVenueData.notes;

  });
  
      },
      child: const Icon(Icons.edit),
    ),
      body: ListView(

        children:
        [
          CarouselSlider(

      items: child,
      
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    ),

  TextField(
      controller: datectrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Date '
      ),
    ),


  GestureDetector(

  onTap: () {
   //print('venue_page : ontap hosted by');
  },
  child:
  new TextField(
      controller: hostctrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Hosted by '
      ),
    ),    
  ),

    TextField(
      controller: namectrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Name'
      ),
    ),

    TextField(
      controller: addressctrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Address'
      ),
    ),

    TextField(
      controller: typectrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Type'
      ),
    ),

  TextField(
      controller: splurgectrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Splurge'
      ),
    ),

  TextField(
      controller: payctrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Who pays'
      ),
    ),

   TextField(
      controller: notesctrl,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Notes'
      ),
    ),

     RaisedButton(
              onPressed: () async {
                
        VenueData retVenueData = new VenueData(retImage,
        retUserName,
        retUserID,
        retStartDateTime,
        retEndDateTime,
        retVenueName,
        retVenueAddress,
        retVenueType,
        retVenueSplurge,
        retVenuePay,
        retVenueNotes);

        VenueDataDao vdatadao = new VenueDataDao();
        List<VenueData> lvdata = new List<VenueData>();
        lvdata.add(retVenueData);

        vdatadao.initialiseWithData(lvdata);
        vdatadao.uploadRecord(0);

              },
              child: Text('Save'),
            ),

        ]
      )
    ),  


  );
  }

}

