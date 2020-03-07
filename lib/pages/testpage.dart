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
                //Map testmap = appData.currentUser.fbuserprofile;
                List<String> photo1 = ['photo 1 url1','photo 1 url2'];
                List<String> photo2 = ['photo 2 url1','photo 2 url2'];


                List<List<String>> userlinks = new List<List<String>>();

                userlinks.add(photo1);
                userlinks.add(photo2);
                print(userlinks[1][0]);

    

              },
            child: Text('Test database'),
           ),

          ],
        )
      ),
   
      
    );
  }
  
} 



