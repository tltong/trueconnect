
import 'package:flutter/material.dart';
import 'package:trueconnect/data/imageobject/image_object.dart';

class TestWillPop extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestWillPopState();
  }
}

class TestWillPopState extends State<TestWillPop>{

ImageObject pageImgObj;
@override
  void initState() {
    super.initState();
  }

@override
  void dispose() {
     super.dispose();
   }


Future<bool> _onBackPressed() {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        new GestureDetector(

          onTap: () => Navigator.of(context).pop(false),
          child: Text("NO"),
        ),
        SizedBox(height: 16),
        new GestureDetector(
//            Navigator.pop(context, pageImgObj);
          onTap: () => Navigator.of(context).pop(true),
          child: Text("YES"),
        ),
      ],
    ),
  ) ??
      false;
}

@override
  Widget build(BuildContext context) {

    final ImageObject imgObj = ModalRoute.of(context).settings.arguments;
    pageImgObj = imgObj;

    return WillPopScope(
    onWillPop: () async {
          // You can await in the calling widget for my_value and handle when complete.
          pageImgObj.downloadlink='https';
          Navigator.pop(context, pageImgObj);
          return false;
        },
    child: new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "On Back pressed",
          style: new TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(

        children:
        [
       RaisedButton(
             onPressed: () 

             async {
              print(pageImgObj.serialise());

               },
            child: Text('Test parameter passing'),
           ),
        ]
      )
      
      
     
    ),
  );
 
  
  }

}