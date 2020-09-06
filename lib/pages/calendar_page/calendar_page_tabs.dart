import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'calendar_page_all.dart';
import '../../data/venuedata/venuedata.dart';
import '../../data/venuedata/venuedata_dao.dart';
import '../../utils/misc_util.dart';

CalendarPageAll cPageAll;

class CalendarPagesTabs extends StatefulWidget {


CalendarPagesTabs(){

    // contruct vdata1
    List<Image> imagelist1 = new  List<Image>();
    File file1 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769468.png');
    Image image1 = Image.file(file1); 
    imagelist1.add(image1);
    VenueData vdata1 = new VenueData(imagelist1,'TL','003',DateTime.now(),DateTime.now(),'Status of Liberty', 'New York', 'Outdoors', '\$\$', VenueData.VENUE_HOST_PAY,'freedom');

    // contruct vdata2
    List<Image> imagelist2 = new  List<Image>();
    File file2 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769547.png');
    Image image2 = Image.file(file2); 
    imagelist2.add(image2);
    VenueData vdata2 = new VenueData(imagelist2,'TL','003',DateTime.now(),DateTime.now(),'Waterfall', 'Niagara Falls', 'Outdoors', '\$', 'Go dutch','wet');

    // contruct vdata3
    List<Image> imagelist3 = new  List<Image>();
    File file3 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image3 = Image.file(file3); 
    imagelist3.add(image3);
    VenueData vdata3 = new VenueData(imagelist3,'TL','003',DateTime.now(),DateTime.now(),'Chicago downtown', 'Chicago', 'City break', '\$\$', VenueData.VENUE_DATE_PAY,'vibrant');

    // contruct vdata4
    List<Image> imagelist4 = new  List<Image>();
    File file4 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image4 = Image.file(file4); 
    imagelist4.add(image4);
    VenueData vdata4 = new VenueData(imagelist4,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 2', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

    // contruct vdata5
    List<Image> imagelist5 = new  List<Image>();
    File file5 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image5 = Image.file(file5); 
    imagelist5.add(image5);
    VenueData vdata5 = new VenueData(imagelist5,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 3', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

    // contruct vdata6
    List<Image> imagelist6 = new  List<Image>();
    File file6 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image6 = Image.file(file6); 
    imagelist6.add(image6);
    VenueData vdata6 = new VenueData(imagelist6,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 4', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

  // contruct vdata7
    List<Image> imagelist7 = new  List<Image>();
    File file7 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image7 = Image.file(file7); 
    imagelist7.add(image7);
    VenueData vdata7 = new VenueData(imagelist7,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 5', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

    // contruct vdata8
    List<Image> imagelist8 = new  List<Image>();
    File file8 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image8 = Image.file(file8); 
    imagelist8.add(image8);
    VenueData vdata8 = new VenueData(imagelist8,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 6', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

 // contruct vdata9
    List<Image> imagelist9 = new  List<Image>();
    File file9 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image9 = Image.file(file9); 
    imagelist9.add(image9);
    VenueData vdata9 = new VenueData(imagelist9,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 7', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

    // contruct vdata10
    List<Image> imagelist10 = new  List<Image>();
    File file10 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image10 = Image.file(file10); 
    imagelist10.add(image10);
    VenueData vdata10 = new VenueData(imagelist10,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 8', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

 // contruct vdata11
    List<Image> imagelist11 = new  List<Image>();
    File file11 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image11 = Image.file(file11); 
    imagelist11.add(image11);
    VenueData vdata11 = new VenueData(imagelist11,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 9', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

    // contruct vdata12
    List<Image> imagelist12 = new  List<Image>();
    File file12 = new File('/data/user/0/com.trueconnect.launch/cache/IMG_1596943769594.png');
    Image image12 = Image.file(file12); 
    imagelist12.add(image12);
    VenueData vdata12 = new VenueData(imagelist12,'TL','004',DateTime.now(),DateTime.now(),'Chicago downtown 10', 'Chicago', 'City break', '\$\$', 'Go dutch','vibrant');

    print('calendar_page_tabs : ' + MiscUtil.ExtractDateStringFromTo(vdata12.startTime,vdata12.endTime));
  

    List<VenueData> venuedataList = new List<VenueData>();
    venuedataList.add(vdata1);
    venuedataList.add(vdata2);
    venuedataList.add(vdata3);

    venuedataList.add(vdata4);
    venuedataList.add(vdata5);
    venuedataList.add(vdata6);
    venuedataList.add(vdata7);
    venuedataList.add(vdata8);
    venuedataList.add(vdata9);
    venuedataList.add(vdata10);
    venuedataList.add(vdata11);
    venuedataList.add(vdata12);

    VenueDataDao vdatadao = new VenueDataDao(12);
    vdatadao.initialiseWithData(venuedataList);

    cPageAll = new CalendarPageAll(vdatadao);

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
             cPageAll,
             // Icon(Icons.account_box),
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