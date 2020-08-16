import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'calendar_page_all.dart';
import '../../data/venuedata/venuedata.dart';
import '../../data/venuedata/venuedata_dao.dart';

CalendarPageAll cPageAll;

class CalendarPagesTabs extends StatefulWidget {


CalendarPagesTabs(){

    // contruct vdata1
    List<Image> imagelist1 = new  List<Image>();
    File file1 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769468.png');
    Image image1 = Image.file(file1); 
    imagelist1.add(image1);
    VenueData vdata1 = new VenueData(imagelist1,'TL','003',DateTime.now(),DateTime.now(),'Status of Liberty', 'New York', 'Outdoors', '\$\$', 'freedom');

    // contruct vdata2
    List<Image> imagelist2 = new  List<Image>();
    File file2 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769547.png');
    Image image2 = Image.file(file2); 
    imagelist2.add(image2);
    VenueData vdata2 = new VenueData(imagelist2,'TL','003',DateTime.now(),DateTime.now(),'Waterfall', 'Niagara Falls', 'Outdoors', '\$', 'wet');

    // contruct vdata3
    List<Image> imagelist3 = new  List<Image>();
    File file3 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image3 = Image.file(file3); 
    imagelist3.add(image3);
    VenueData vdata3 = new VenueData(imagelist2,'TL','003',DateTime.now(),DateTime.now(),'Chicago downtown', 'Chicago', 'City break', '\$\$', 'vibrant');

    List<VenueData> venuedataList = new List<VenueData>();
    venuedataList.add(vdata1);
    venuedataList.add(vdata2);
    venuedataList.add(vdata3);


    VenueDataDao vdatadao = new VenueDataDao(3);
    vdatadao.initialiseWithData(venuedataList);

    List<VenueData> retvenuedataList = vdatadao.RetrieveVenueData(4);
    print('Calendar page tabs : ' + retvenuedataList.toList().toString()); 


 //   cPageAll = new CalendarPageAll(venuedataList);

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
             //cPageAll,
              Icon(Icons.account_box),
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