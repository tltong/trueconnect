import './fs_query_int.dart';
import './fs_where_equal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FS_QUERY_EQUAL extends FS_QUERY_INT {

  String collection;
  String orderby;
  int limit;
  List<DocumentSnapshot> documentList;  

  String field;
  String value;

  FS_QUERY_EQUAL(String inCollection, FS_WHERE_EQUAL inFSwhere, String inOrderby){
    collection = inCollection;
    orderby = inOrderby;
    field = inFSwhere.field;
    value = inFSwhere.value;
  }

  Future<List<Map<String, dynamic>>> executeQuery(Firestore databaseReference,int limit) async {

    QuerySnapshot query;

    if (limit==0){
      List<Map<String, dynamic>> ret = new List();
      return ret;
    }

    if (documentList==null){      // fetch first

      query = await databaseReference.collection(collection).orderBy(orderby).where(field, isEqualTo: value).limit(limit).getDocuments();
      documentList = query.documents;
      return _processQuery(query);

    }else{                      // fetch next

      List<DocumentSnapshot> newDocumentList;
      query = await databaseReference.collection(collection).orderBy(orderby).where(field, isEqualTo: value).startAfterDocument(documentList[documentList.length - 1]).limit(limit).getDocuments();

      newDocumentList = query.documents;
      documentList.addAll(newDocumentList);

      return _processQuery(query);
    }
  }      

  List<Map<String, dynamic>> _processQuery(QuerySnapshot query){

    List<Map<String, dynamic>> ret = new List();
    for (int i=0;i<query.documents.length;i++){
      DocumentSnapshot ds = query.documents[i];
      Map<String, dynamic> retMap = new Map<String, dynamic>();
      retMap.addAll(ds.data);
      ret.add(retMap);
    }

    return ret;

  }

  test(){
     if (documentList==null){
       print('documentList is null');
     }else{
       print('documentList is not null');
     }
  }
}