import 'package:flutter/material.dart';
import 'package:trueconnect/user.dart';
import 'package:provider/provider.dart';


class CreateUser extends StatelessWidget {
  final teName = TextEditingController();
  final teEmail = TextEditingController();
  final teAge = TextEditingController();
  final teMobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create user"),
      ),
      body: new Stack(

          children: <Widget>[

             new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/jap2.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          new Center (
          child: Column
          (children: <Widget>[
          
            getTextField("Name", teName),
            getTextField("Email", teEmail),
            getTextField("Age", teAge),
            getTextField("Mobile", teMobile),

            RaisedButton(
              onPressed: () {

                Provider.of<User>(context).updateUser(teName.text, teEmail.text, teAge.text, teMobile.text);
           
              },
            child: Text('Create User'),
           ),

            RaisedButton(
              onPressed: () {
              Navigator.pop(context);
              },
            child: Text('Go back!'),
           ),

          ]),
            
        )]));
    
  }


}

Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        style: TextStyle(color: Colors.white),
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
	hintStyle: TextStyle(
                  color: Colors.white
                ),
        ),
      ),
    );

    return loginBtn;
  }

  abstract class AddUserCallback {
  void addUser(User user);

}
