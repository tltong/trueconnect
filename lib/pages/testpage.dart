import 'package:flutter/material.dart';
import 'package:trueconnect/utils/appdata.dart';
import '../utils/fs_util.dart';


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
            
             RaisedButton(
              onPressed: () {
              Navigator.pop(context);
              },
            child: Text('Go back!'),
           ),
           RaisedButton(
              onPressed: () {
               FS_Util fs = new FS_Util();
               fs.queryDoc('users','id',appData.currentUser.id).then((doc){
                  print(doc[0]['documentID']);
              });

    

              },
            child: Text('Test database'),
           ),

          ],
        )
      ),
   
      
    );
  }
  
} 



