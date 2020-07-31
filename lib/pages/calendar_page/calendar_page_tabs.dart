import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon.dart';


class CalendarPagesTabs extends StatefulWidget {

CalendarPagesTabs(){
}

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalendarPagesTabsState();
  }

}


class CalendarPagesTabsState extends State<CalendarPagesTabs>  {

final PageStorageBucket bucket = PageStorageBucket();

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

  MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: 
        
        Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                new Text("All"),
                new Text("Going"),
                new Text("Saved"),
                new Text("Past"),
              ],
            ),
            title: Text('Your Calendar'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
             onPressed:() async{  
                Navigator.pop(context);
               },
            )
          ),
          body: 
          PageStorage(
          bucket: bucket,
          child:
          TabBarView(
            children: [
              Icon(Icons.ac_unit),
              Icon(Icons.access_alarm),
              Icon(Icons.access_time),
              Icon(Icons.accessibility),
            ],
          ),
        ),
      ),
    )

  );


 }  // build


}