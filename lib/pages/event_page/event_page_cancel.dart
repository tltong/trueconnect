import 'package:flutter/material.dart';
import '../../data/venuedata/venuedata.dart';
import '../../utils/appdata.dart';

class EventPageCancel extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EventPageCancelState();
  }
}

class EventPageCancelState extends State<EventPageCancel>{


  final commentController = TextEditingController();

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

    VenueData retVenueData = argVenueData;

    final String dateName = argVenueData.userName;
    String venueName = argVenueData.name;

  //  print('event page go:'+argVenueData.name.toString() );
   
    return WillPopScope(
    onWillPop: () async {
          // You can await in the calling widget for my_value and handle when complete.
   
          Navigator.pop(context);
          return false;
        },
    child: new Scaffold(
      appBar: new AppBar(
 /*   
        title: new Text(
          "On Back pressed",
          style: new TextStyle(color: Colors.white),
        ),
 */
 
      ),
      body: ListView(

        children:
        [
        
    Text('\nCancel date to '),
    Text(
        venueName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    Text('with'),
    Text(
        dateName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('?\n\n'),
   
    

 Text('\n'),

       RaisedButton(
             onPressed: () 

             async {
                String userID=appData.currentUser.getID();
                String comment = commentController.text;

                retVenueData.removeApplicant(userID);
                retVenueData.removeApplicantComment(userID);

                Navigator.pop(context, retVenueData);

                },
             child: Text('Cancel'),
             color: Colors.red,
            textColor: Colors.white,
           ),
        ]
      )
      
      
     
    ),
  );


  }
}