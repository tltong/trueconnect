import 'package:flutter/material.dart';
import 'package:trueconnect/utils/appdata.dart';


class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestPageState();
  }
}


class TestPageState extends State<TestPage>{

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

 return Scaffold(
      appBar: AppBar(
        title: Text("Test page"),
      ),

      body: 
       new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            appData.fbtoken != null ? Text(appData.fbtoken):Text('Not logged in on FB'),
             RaisedButton(
              onPressed: () {
              Navigator.pop(context);
              },
            child: Text('Go back!'),
           ),

          ],
        )
      ),
   
      
    );
  }
  
} 



