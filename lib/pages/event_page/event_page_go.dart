import 'package:flutter/material.dart';
import '../../data/venuedata/venuedata.dart';
import '../../utils/appdata.dart';

class EventPageGo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EventPageGoState();
  }
}

class EventPageGoState extends State<EventPageGo>{


  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
     super.dispose();
   }


  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content,  style: TextStyle(fontWeight: FontWeight.bold));
  }

  Text returnText (String inText){
    return Text(inText);

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
        
    Text('\nGo on a date to '),
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
   
    
/*
   const Text.rich(
  TextSpan(
    text: '\nGo on a date', // default text style
    children: <TextSpan>[
      TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
     ],
  ),
),
*/

    Text('Tell your date something about yourself'),

TextField(
  controller: commentController,
   keyboardType: TextInputType.multiline,
  maxLines: null,
  decoration: InputDecoration(
    border: OutlineInputBorder()
  )
),

 Text('\n'),

       RaisedButton(
             onPressed: () 

             async {
                String userID=appData.currentUser.getID();
                String comment = commentController.text;

                retVenueData.addApplicant(userID);
                retVenueData.addApplicantComment(userID, comment);

//                print('event_page_go : '+retVenueData.applicants.toString());
//                print('event_page_go : '+retVenueData.applicant_comments.toString());
                Navigator.pop(context, retVenueData);

                },
             child: Text('Confirm'),
             color: Colors.red,
            textColor: Colors.white,
           ),
        ]
      )
      
      
     
    ),
  );


  }
}