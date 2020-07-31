import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalendarPageState();
  }
}

class CalendarPageState extends State<CalendarPage>{

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

  return

    WillPopScope(
    onWillPop: () async {
    
           Navigator.pop(context);
          return false;
        },    // onwillpop async
    child: 
     
     new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Your Calendar",
          style: new TextStyle(color: Colors.white),
        ),
      ),
 
      body: ListView(

        children:
        [

    TextField(
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Name'
      ),
    ),

        ]   // children
      )   //listiview 
    ),  //scaffold


  );  //w
 
  }   //build
}