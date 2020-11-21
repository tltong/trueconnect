import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './FS_Util/fs_where_int.dart';
import 'dart:io';

import 'FS_Util/fs_query_equal.dart';
import 'FS_Util/fs_query_factory.dart';
import 'FS_Util/fs_query_int.dart';
import 'FS_Util/fs_where_equal.dart';
import 'FS_Util/fs_query_equal_double.dart';

class FS_Util{

  static String VENUE_COLLECTION = 'venues';

  final databaseReference = Firestore.instance;

  // for paginate query
  List<DocumentSnapshot> documentList;  
  String listCollection;
  
  void createRecord(String collection, String field, String value) async {

      DocumentReference ref = await databaseReference.collection(collection)
      .add({
        field: value,
      });
 //   print("saving to fs" + ref.documentID);
  }

  /*
  Usage example:
  FS_Util fs = new FS_Util();
    fs.queryDoc('newbooks','author','Jack London').then((doc){
    print(doc.length);
  });
  */
  Future<List<Map<String, dynamic>>> queryDoc(String collection,String field, String value) async {
      
    var query = await databaseReference.collection(collection).where(field,isEqualTo: value).getDocuments();

    // this somehow does not work   
    //String para = field + ',' + 'isEqualTo: ' + value;
    //var query = await databaseReference.collection(collection).where(para).getDocuments();

    List<Map<String, dynamic>> ret = new List();

    
    for (int i=0;i<query.documents.length;i++){
      DocumentSnapshot ds = query.documents[i];
      Map<String, dynamic> retMap = new Map<String, dynamic>();
      retMap.addAll(ds.data);
      retMap.putIfAbsent('documentID', () => ds.documentID);
      ret.add(retMap);
    }
    return ret;
  }


  Future<List<Map<String, dynamic>>> testQuery(String collection,String field, String value) async {
      
    List<Map<String, dynamic>> ret = new List();

    FS_WHERE_EQUAL fswhereeq = new FS_WHERE_EQUAL(field,value);

    FS_QUERY_EQUAL fsqueryeq = new FS_QUERY_EQUAL(FS_Util.VENUE_COLLECTION,fswhereeq,'name');

    var doc = await fsqueryeq.executeQuery(databaseReference, 1);
    print(doc.length.toString());
    print(doc.toString());
    
     doc = await fsqueryeq.executeQuery(databaseReference, 1);
    print(doc.length.toString());
    print(doc.toString());
    
    return ret;
  }



    Future<void> testFactory() async {


      FS_WHERE_EQUAL fswhereeq = new FS_WHERE_EQUAL("userName", "Tai-Loong Tong");
      List<FS_WHERE_EQUAL> fswherelist = new List<FS_WHERE_EQUAL>();
      fswherelist.add(fswhereeq);
      

      FS_QUERY_INT fsqueryint = FS_QUERY_FACTOR.createQUERY(FS_Util.VENUE_COLLECTION, fswherelist, "name");

      
      var doc = await fsqueryint.executeQuery(databaseReference, 2);
      for (int i=0;i<doc.length;i++)
        print(doc[i]);

      doc = await fsqueryint.executeQuery(databaseReference, 1);
      for (int i=0;i<doc.length;i++)
        print(doc[i]);


    }


    Future<List<Map<String, dynamic>>> testQueryEqDouble(String collection,String field1, String value1,String field2, String value2) async {
      
    List<Map<String, dynamic>> ret = new List();

    FS_WHERE_EQUAL fswhereeq1 = new FS_WHERE_EQUAL(field1,value1);
    FS_WHERE_EQUAL fswhereeq2 = new FS_WHERE_EQUAL(field2,value2);

    FS_QUERY_EQUAL_DOUBLE fsqueryeq = new FS_QUERY_EQUAL_DOUBLE(FS_Util.VENUE_COLLECTION,fswhereeq1,fswhereeq2,'name');

    var doc = await fsqueryeq.executeQuery(databaseReference, 1);
    
    for (int i=0;i<doc.length;i++)
      print(doc[i]);
    
    doc = await fsqueryeq.executeQuery(databaseReference, 1);

    for (int i=0;i<doc.length;i++)
      print(doc[i]);
    
    return ret;
  }

  List<Map<String, dynamic>> returnRet (var inQuery){

    List<Map<String, dynamic>> ret = new List<Map<String, dynamic>>();
    List<DocumentSnapshot> dsList = inQuery.documents;


    return ret;

  }

   Future<List<Map<String, dynamic>>> fetchFirstList(String collection, List<FS_WHERE_INT> whereList, String orderby, int limit) async {
        
     if(whereList.length==1){

        String queryStr;
        print(queryStr);

        var query = await databaseReference.collection(collection).orderBy(orderby).where(queryStr).limit(limit).getDocuments();
      
        print(query);
        
        List<DocumentSnapshot> dsList = query.documents;
        print(dsList.length);

/*
        List<Map<String, dynamic>> ret = new List<Map<String, dynamic>>();

        for (int i=0;i<dsList.length;i++){
          ret.add(dsList[i].data);
        }
      */
        return null;
      }
  }


  Future<List<Map<String, dynamic>>> fetchNextList() async {

    return null;

  }




  Future<List<Map<String, dynamic>>> paginateQueryDoc(String collection,String field, String value, String orderby, int limit) async {
      
  //  print('fs util first query : ');  

    var query = await databaseReference.collection(collection).orderBy(orderby).where(field,isEqualTo: value).limit(limit).getDocuments();
    documentList = query.documents;
  //  print('fs util : documentlist length : '+ documentList.length.toString());

    // this somehow does not work   
    //String para = field + ',' + 'isEqualTo: ' + value;
    //var query = await databaseReference.collection(collection).where(para).getDocuments();

    List<Map<String, dynamic>> ret = new List();

    
    for (int i=0;i<query.documents.length;i++){
      DocumentSnapshot ds = query.documents[i];
      Map<String, dynamic> retMap = new Map<String, dynamic>();
      retMap.addAll(ds.data);
      retMap.putIfAbsent('documentID', () => ds.documentID);
      ret.add(retMap);
    }
    return ret;
  }

  Future<List<Map<String, dynamic>>> paginateQueryDocNext(String collection,String field, String value, String orderby, int limit) async {

  //  print('*** fs util next query : ***');  
   /*   

    print('fs util : documentlist length before : '+ documentList.length.toString());
    for (int i=0;i<documentList.length;i++){
        print( documentList[i].data.toString());
    }
    */

     List<DocumentSnapshot> newDocumentList;
      var query = await databaseReference.collection(collection).orderBy(orderby).where(field,isEqualTo: value).startAfterDocument(documentList[documentList.length - 1]).limit(limit).getDocuments();
    
    newDocumentList = query.documents;
    documentList.addAll(newDocumentList);
    /*
    print('fs util : query.documents : '+ query.documents.length.toString());
    for (int i=0;i<query.documents.length;i++){
        print( query.documents[i].data.toString());
    }*/
    
    


    // this somehow does not work   
    //String para = field + ',' + 'isEqualTo: ' + value;
    //var query = await databaseReference.collection(collection).where(para).getDocuments();

    List<Map<String, dynamic>> ret = new List();

 //   print('fs util : query documents length :'+query.documents.length.toString());    
    for (int i=0;i<query.documents.length;i++){
      DocumentSnapshot ds = query.documents[i];
      Map<String, dynamic> retMap = new Map<String, dynamic>();
      retMap.addAll(ds.data);
      retMap.putIfAbsent('documentID', () => ds.documentID);
      ret.add(retMap);
    }
/*
    print('fs util : ret : '+ ret.length.toString());
    for (int i=0;i<ret.length;i++){
        print( ret[i].toString());
    }
*/
    return ret;
  }





  /*
  Usage example: 
  Map<String,String> bookList= new Map<String, String>();
  bookList['Title'] = "white fang";
  bookList['author'] = "Jack London";
  bookList['Rating'] = "Five star";
  FS_Util fs = new FS_Util();
  fs.addRecord('newbooks', bookList).then((id){
                  Map<String,String> bookListUpdate= new Map<String, String>();
                  bookListUpdate['ID'] = id;
                  fs.updateRecord('newbooks', id, bookListUpdate);
    }
  );
  */
  Future<String> addRecord(String collection, Map<String, dynamic> mapDoc) async {
    DocumentReference ref = await databaseReference.collection(collection).add(mapDoc);
    return ref.documentID;
  }

  Future<void> updateRecord(String collection, String doc, Map<String, dynamic> mapDoc) async {
    databaseReference.collection(collection).document(doc).updateData(mapDoc);
  }

/* Usage example:
    FS_Util fs = new FS_Util();
    fs.uploadFile('member/image',sampleImage).then((id){
                   print('uploading complete : ' + id);
                 });
    This can also be used to replace file
*/
Future<String>uploadFile(String path, File image) async {    
  
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child(path);    
   StorageUploadTask uploadTask = storageReference.putFile(image);    
   await uploadTask.onComplete;    
   String downloadUrl = await storageReference.getDownloadURL();
   return downloadUrl;
 }

 Future<void>deleteFile(String path) async {

   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child(path);   
   await storageReference.delete();    
   return;  
  }


}