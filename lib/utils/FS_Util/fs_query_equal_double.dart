import './fs_query_int.dart';
import './fs_where_equal.dart';
import './fs_where_int.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FS_QUERY_EQUAL_DOUBLE extends FS_QUERY_INT {

  String collection;
  String orderby;
  int limit;
  List<DocumentSnapshot> documentList;  

  String field1;
  String value1;

  String field2;
  String value2;


  FS_QUERY_EQUAL_DOUBLE(String inCollection, FS_WHERE_INT inFSwhere1, FS_WHERE_INT inFSwhere2, String inOrderby){
    collection = inCollection;
    orderby = inOrderby;
    field1 = (inFSwhere1 as FS_WHERE_EQUAL).field;
    value1 = (inFSwhere1 as FS_WHERE_EQUAL).value;

    field2 = (inFSwhere2 as FS_WHERE_EQUAL).field;
    value2 = (inFSwhere2 as FS_WHERE_EQUAL).value;



  }

  Future<List<Map<String, dynamic>>> executeQuery(Firestore databaseReference,int limit) async {

    QuerySnapshot query;

    if (limit==0){
      List<Map<String, dynamic>> ret = new List();
      return ret;
    }

    if (documentList==null){      // fetch first

      query = await databaseReference.collection(collection).orderBy(orderby).where(field1, isEqualTo: value1).where(field2, isEqualTo: value2).limit(limit).getDocuments();
      
      documentList = query.documents;
      return _processQuery(query);

    }else{                      // fetch next

      List<DocumentSnapshot> newDocumentList;
      query = await databaseReference.collection(collection).orderBy(orderby).where(field1, isEqualTo: value1).where(field2, isEqualTo: value2).startAfterDocument(documentList[documentList.length - 1]).limit(limit).getDocuments();

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

}