import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../data/venue/venue.dart';
import '../../data/venue/venue_factory.dart';
import '../../data/imageobject/image_mediator.dart';
import '../../data/venuedata/venuedata.dart';

class HostListItem extends StatelessWidget {
  const HostListItem({
  //  this.thumbnail,
 //   this.title,
 //   this.time,
 //   this.type,
    this.host,
   // this.pay
  });

 // final Widget thumbnail;
//  final String title;
//  final String time;
//  final String type;
  final String host;
 // final String pay;


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: 
                
      
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
/*
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
  */   
     
          Expanded(
            flex: 3,
            child: _HostDescription(
    //          title: title,
     //         time:time,
     //         type:type,
              host:host,
     //         pay:pay

            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _HostDescription extends StatelessWidget {
  const _HostDescription({
    Key key,
  //  this.title,
  //  this.time,
  //  this.type,
    this.host,
 //   this.pay
  }) : super(key: key);

 // final String title;
 // final String time;
 // final String type;
  final String host;
  final String nothing=' ';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: 
            
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
   
          Text(
            host,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
           
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
           ],
      ),

    
    );
  }
}



class EventPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EventPageState();
  }
}

class EventPageState extends State<EventPage>{


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

List<Image> imageslocal = new List<Image>();


for (int i=0;i<inImages.length;i++){
  imageslocal.add(inImages[i]);
}


if (imageslocal.length==0) imageslocal.add(Image.asset('images/no-image.png'));


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

return child;
}




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

    final VenueData argVenueData = ModalRoute.of(context).settings.arguments;
    List<Image> argImages = argVenueData.images;
//    print('event page : ' + vdata.name.toString());

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
    
    argVenueData.startTime.day.toString()+'-'+argVenueData.startTime.month.toString()+'-'+argVenueData.startTime.year.toString()
    + " (" + DayOfWeek[argVenueData.startTime.weekday] + ") " + 
    
    argVenueData.startTime.hour.toString()+':'+ argVenueData.startTime.minute.toString()
    + ' - ' +'\n';

    dateString += argVenueData.endTime.day.toString() 
    +'-'+argVenueData.endTime.month.toString()+'-'+argVenueData.endTime.year.toString()
    + " (" + DayOfWeek[argVenueData.endTime.weekday] + ") "
     +   argVenueData.endTime.hour.toString()+':'+ argVenueData.endTime.minute.toString();

  datectrl.text=dateString;
    hostctrl.text=argVenueData.userName;
    namectrl.text=argVenueData.name;
    addressctrl.text=argVenueData.address;
    typectrl.text=argVenueData.type;
    splurgectrl.text=argVenueData.splurge;

    String paytext;
    
    if (argVenueData.pay == VenueData.VENUE_HOST_PAY){
      paytext = "Host will pay";
    }
    else if (argVenueData.pay == VenueData.VENUE_DATE_PAY){
      paytext = "You will pay";
    }else if (argVenueData.pay == VenueData.VENUE_GO_DUTCH){
      paytext = "Go dutch";
    }

    payctrl.text=paytext;
    notesctrl.text=argVenueData.notes;

 List<Image> inImages = argImages;

      if (this.child==null){
      

      List images=_initialiseChild(context, inImages);
      this.child=images;
    }

   return 
    WillPopScope (

    


   child: Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: 
 
          ListView(children: 
          <Widget>[

             GestureDetector(

             onTap: () {
           //   print('event page : host on tap');

             },
             child: 
              HostListItem(host: 'TL',),
              
            ),
            
            
            const Divider(
            color: Colors.blueGrey,
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 0,
          ),

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
        labelText: 'Why you should go'
      ),
    ),


          ],)
        
  
  
      
    ), 
    
    
    
    onWillPop: () async {
        Navigator.pop(context, 'willpop');
          return false;


    }
  );
  
  }

}