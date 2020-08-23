import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';
import 'dart:math';
import '../../data/venuedata/venuedata.dart';
import '../../data/venuedata/venuedata_dao.dart';


VenueDataDao vDataDao;
//final _pairList = <String>[];
  final _pairList = <String>[];


class CalendarPageAll extends StatefulWidget {



//CalendarPageAll(List<VenueData> inVdataList){
CalendarPageAll(VenueDataDao inVDataDao){

 // print('calendar_page_all constructor');
  vDataDao= inVDataDao;
  _pairList.clear();
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
//  Future<List<WordPair>> fetch() async {
    Future<List<String>> fetch() async {
 //   print ('calendar_page_all : fetch start1 index : '+ index.toString());
    
    var random = new Random();
    var ranIndex = random.nextInt(2);
    List<VenueData> retrievedVdatalist;

   // final list = <WordPair>[];
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
    print('calendar_page_all : fetch list : ' + list.toString());
  
    return list;
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
  //  print('calendar page all : loadmore before fetching : _pairList length ' + _pairList.length.toString() );
//    print('calendar page all : loadmore before fetching : vDataDao length ' + vDataDao.retrieveCount().toString() );

    if (_pairList.length >= vDataDao.retrieveCount()){
  
          _isLoading = false;
          _hasMore = false;
        return;

    }

    // ************

      _itemFetcher.fetch().then((List<String> fetchedList) {

    //   print('calendar page all : fetchedlist length ' + fetchedList.length.toString() );
   
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _pairList.addAll(fetchedList);

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

@override
Widget build(BuildContext context) {

  


 return ListView.builder(

      itemCount: _hasMore ? _pairList.length + 1 : _pairList.length,
      itemBuilder: (BuildContext context, int index) {
      //print('calendar_page_all build : _pairList length : ' + _pairList.length.toString());

       // print('calendar_page_all build : index : ' + index.toString());
        // Uncomment the following line to see in real time how ListView.builder works
       //  print('ListView.builder is building index $index');
        if (index >= _pairList.length) {
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
        return ListTile(
          leading: Text(index.toString(), style: _biggerFont),
          title: Text(_pairList[index], style: _biggerFont),
        );
      },
    );

/*
    return ListView.builder(
      // Need to display a loading tile if more items are coming
      itemCount: _hasMore ? _pairList.length + 1 : _pairList.length,
      itemBuilder: (BuildContext context, int index) {
        // Uncomment the following line to see in real time how ListView.builder works
        // print('ListView.builder is building index $index');
        if (index >= _pairList.length) {
          // Don't trigger if one async loading is already under way
          if (!_isLoading) {
            _loadMore();
          }
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 24,
              width: 24,
            ),
          );
        }
        return ListTile(
          leading: Text(index.toString(), style: _biggerFont),
          title: Text(_pairList[index].asPascalCase, style: _biggerFont),
        );
      },
    );
*/
  }

}