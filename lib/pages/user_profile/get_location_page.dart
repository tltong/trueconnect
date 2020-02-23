
import 'package:flutter/material.dart';
import '../../utils/location_util.dart';

class GetLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get location'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Get location'),
          onPressed: () {
              LocationUtil loc = new LocationUtil();
              loc.getLocation().then((ret){
               print('location page ' + loc.country);
              });
          },
        ),
      ),
    );
  }
}