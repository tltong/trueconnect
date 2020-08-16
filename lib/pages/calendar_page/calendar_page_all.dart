import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';
import 'dart:math';
import '../../data/venuedata/venuedata.dart';
import '../../data/venuedata/venuedata_dao.dart';

List<VenueData> vdataList;
VenueDataDao vDataDao;


class CalendarPageAll extends StatefulWidget {



//CalendarPageAll(List<VenueData> inVdataList){
CalendarPageAll(VenueDataDao inVDataDao){

  vDataDao= inVDataDao;

  vdataList = vDataDao.retrieveVenueData(vDataDao.retrieveCount());

  print('calendar_page : vdataList length : ' + vdataList.length.toString());

    
}

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalendarPageAllState();
  }

}

class _ItemFetcher {
  final _count = vdataList.length;
  final _itemsPerPage = 4;
  int _currentPage = 0;
  int index=0;



  // *******

  // This async function simulates fetching results from Internet, etc.
//  Future<List<WordPair>> fetch() async {
    Future<List<String>> fetch() async {
    
    var random = new Random();
    var ranIndex = random.nextInt(2);

   // final list = <WordPair>[];
   final list = <String>[];
    final n = min(_itemsPerPage, _count - _currentPage * _itemsPerPage);
  //  print('fetch - n vallue ' + n.toString());

    // Uncomment the following line to see in real time now items are loaded lazily.
    // print('Now on page $_currentPage');
    await Future.delayed(Duration(seconds: 1), () {
      //  print('index : ' + index.toString());
      for (int i = 0; i < n; i++) {
      //  list.add(WordPair.random());
      list.add(vdataList[index].name.toString());
      index++;
    
        
      }
    });
    _currentPage++;
    print('list : ' + list.toString());
    return list;
  }
}


class CalendarPageAllState extends State<CalendarPageAll>  {

  // ********

//  final _pairList = <WordPair>[];
  final _pairList = <String>[];



  final _biggerFont = const TextStyle(fontSize: 40.0);
  final _itemFetcher = _ItemFetcher();

    bool _isLoading = true;
  bool _hasMore = true;

final PageStorageBucket bucket = PageStorageBucket();

void initState() {

    super.initState();
      _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

void _loadMore() {
      print('loadmore');
    _isLoading = true;

    // ************

    _itemFetcher.fetch().then((List<String> fetchedList) {
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _pairList.addAll(fetchedList);
        });
      }
    });
  }


@override
  void dispose() {

    super.dispose();
  }

@override
Widget build(BuildContext context) {

 return ListView.builder(
   
      itemCount: _hasMore ? _pairList.length + 1 : _pairList.length,
      itemBuilder: (BuildContext context, int index) {
        // Uncomment the following line to see in real time how ListView.builder works
         print('ListView.builder is building index $index');
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