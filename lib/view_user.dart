import 'package:flutter/material.dart';
import 'package:trueconnect/user.dart';
import 'package:provider/provider.dart';

class ViewUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View user"),
      ),
      body: 
      
      new Stack(
        children: <Widget> [ 
           new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/jap3.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

      new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Name : ' + Provider.of<User>(context).user['name'].toString()),
            Text('Email : ' + Provider.of<User>(context).user['email'].toString()),
            Text('Age : '+ Provider.of<User>(context).user['age'].toString()),
            Text('Mobile : ' + Provider.of<User>(context).user['mobile'].toString()),

            RaisedButton(
              onPressed: () {
              Navigator.pop(context);
              },
            child: Text('Go back!'),
           ),

          ],
        )
      ),
        ])

    );
  }
}