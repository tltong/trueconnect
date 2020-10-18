import 'package:flutter/material.dart';
import 'dart:math';
import '../../data/venuedata/venuedata.dart';
import '../../data/venuedata/venuedata_dao.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../utils/misc_util.dart';
import '../event_page/event_page.dart';
import '../../data/venuedata/venuedata.dart';

VenueDataDao vDataDao;
//final _pairList = <String>[];
  final _pairList = <String>[];
  final _vdatalist = <VenueData>[];

class VenueListItem extends StatelessWidget {
  const VenueListItem({
    this.thumbnail,
    this.title,
    this.time,
    this.type,
    this.host,
   // this.pay
  });

  final Widget thumbnail;
  final String title;
  final String time;
  final String type;
  final String host;
 // final String pay;


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: 
                
      
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VenueDescription(
              title: title,
              time:time,
              type:type,
              host:host,
     //         pay:pay

            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _VenueDescription extends StatelessWidget {
  const _VenueDescription({
    Key key,
    this.title,
    this.time,
    this.type,
    this.host,
 //   this.pay
  }) : super(key: key);

  final String title;
  final String time;
  final String type;
  final String host;
  final String nothing=' ';
 // final String pay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: 
      
      
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
           Text(
            type,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
           Text(
            nothing,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
          Text(
            host,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
   
         
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
   
        ],
      ),

    
    );
  }
}


class CalendarPageAll extends StatefulWidget {

//CalendarPageAll(List<VenueData> inVdataList){
CalendarPageAll(VenueDataDao inVDataDao){

 // print('calendar_page_all constructor');
  vDataDao= inVDataDao;
  _pairList.clear();
  _vdatalist.clear();
 // vDataDao.resetIndex();

 // vdataList = vDataDao.retrieveVenueData(vDataDao.retrieveCount());



   
}

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalendarPageAllState();
  }

}

class _ItemFetcher {
  final _count = vDataDao.count;
  final _itemsPerPage = 3;
  int _currentPage = 0;
  int index=0;

  // *******

  // This async function simulates fetching results from Internet, etc.

    Future<List<VenueData>> fetch() async {

   // Future<List<String>> fetch() async {
 //   print ('calendar_page_all : fetch start1 index : '+ index.toString());
    
    var random = new Random();
    var ranIndex = random.nextInt(2);
    List<VenueData> retrievedVdatalist;

  
   final list = <String>[];
    final n = min(_itemsPerPage, _count - _currentPage * _itemsPerPage);
 //  print('calendar page : fetch n value ' + n.toString());
   // print('calendar page : vDataDao index ' + vDataDao.index.toString());
    retrievedVdatalist = vDataDao.retrieveVenueData(n);
  //  print('calendar page : retrievedVdatalist length ' + retrievedVdatalist.length.toString());

    // Uncomment the following line to see in real time now items are loaded lazily.
    // print('Now on page $_currentPage');
    await Future.delayed(Duration(seconds: 1), () {
     //   print ('calendar_page_all : fetch start2 index : '+ index.toString());
      
      
      for (int i = 0; i < retrievedVdatalist.length; i++) {
       // list.add(WordPair.random());
    //  print('calendar page : i vallue ' + i.toString());
    //  print('calendar page : index value : ' + index.toString());

      list.add(retrievedVdatalist[i].name.toString());
      index++;
       
      }
    });
    _currentPage++;
  //  print('calendar_page_all : fetch list : ' + retrievedVdatalist.toString());
    return retrievedVdatalist;
   // return list;
  }
}


class CalendarPageAllState extends State<CalendarPageAll>  {

  // ********

//  final _pairList = <WordPair>[];


  final _biggerFont = const TextStyle(fontSize: 40.0);
  final _itemFetcher = _ItemFetcher();

    bool _isLoading = true;
  bool _hasMore = true;

final PageStorageBucket bucket = PageStorageBucket();

void initState() {

 //   print('calendar_page_all : init');
  //  print('calendar_page init : vdataList length : ' + vDataDao.retrieveCount().toString());
  //print('calendar_page init : pairlist.length : ' + _pairList.length.toString());
 


    super.initState();
      _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

void _loadMore() {
   
    _isLoading = true;
 //   print('calendar page all : loadmore before fetching : _vdatalist length ' + _vdatalist.length.toString() );
//    print('calendar page all : loadmore before fetching : vDataDao length ' + vDataDao.retrieveCount().toString() );

//    if (_pairList.length >= vDataDao.retrieveCount()){
    if (_vdatalist.length >= vDataDao.retrieveCount()){
          _isLoading = false;
          _hasMore = false;
        return;

    }

    // ************
     _itemFetcher.fetch().then((List<VenueData> fetchedList) {

//      _itemFetcher.fetch().then((List<String> fetchedList) {

    //   print('calendar page all : fetchedlist length ' + fetchedList.length.toString() );
   
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _vdatalist.addAll(fetchedList);

      //     print('calendar page all : loadmore after fetching : _pairList length ' + _pairList.length.toString() );
   //         print('calendar page all : loadmore after fetching : vDataDao length ' + vDataDao.retrieveCount().toString() );

        });
      }
    });
  }


@override
  void dispose() {
//    print('calendar_page_all : dispose');
   // print('calendar_page_all dipose : pairlist.length : ' + _pairList.length.toString());


   // _pairList.clear();
    super.dispose();
  }


Widget _Dialog(BuildContext context, List<Image> displayImages) {
    return new AlertDialog(
      //title: const Text('About Pop up'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
/*
        children: <Widget>[
          displayImage,
        ],
*/
        children: <Widget>[

 CarouselSlider(

      items: displayImages,
      
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    ),

          
        ],


        
      )
    );
}

@override
Widget build(BuildContext context) {




 return 


 ListView.builder(

    padding: const EdgeInsets.all(8.0),
    itemExtent: 106.0,

      itemCount: _hasMore ? _vdatalist.length + 1 : _vdatalist.length,

      itemBuilder: (BuildContext context, int index) {

        if (index >= _vdatalist.length) {
          // Don't trigger if one async loading is already under way
          if (!_isLoading) {
            _loadMore();
          }

          if ( _isLoading == false && _hasMore == false){
            return null;
          }

          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 24,
              width: 24,
            ),
          );
        }


      // reference : https://api.flutter.dev/flutter/material/ListTile-class.html

      String payString;

      if (_vdatalist[index].pay==VenueData.VENUE_GO_DUTCH){
          payString = VenueData.VENUE_GO_DUTCH;
      }
      if (_vdatalist[index].pay==VenueData.VENUE_HOST_PAY){
          payString = 'Your date will pay';
      }
      if (_vdatalist[index].pay==VenueData.VENUE_DATE_PAY){
          payString = 'You will pay';
      }

        return 

(
Container(
 child: GestureDetector(
                
   onTap: () async {
//     print('calendar page all : on tap');

final result = await
Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventPage(),
            settings: RouteSettings(
              arguments: _vdatalist[index],
            ),
          ),
        );
print('caledar page all : '+ result.toString());
   },
  
  child: VenueListItem(
        thumbnail: 
        Container(
          child:  
           GestureDetector(
             onTap: () {
                
                 showDialog(
            context: context,
            builder: (BuildContext contextcopy) => 
            _Dialog(contextcopy,_vdatalist[index].images),
          );
                },
           child: Image(image:  _vdatalist[index].images[0].image),
           )
        ),

        
          title: _vdatalist[index].name + ' ' + '(' + _vdatalist[index].type + ')',
        

          time: MiscUtil.ExtractDateStringFromTo( _vdatalist[index].startTime, _vdatalist[index].endTime),
          type: _vdatalist[index].splurge + '   ' + payString,
          host: 'Hosted by : ' + _vdatalist[index].userName,

      )

)

)


);


      },
    ); // ListView.builder
  

  }

}