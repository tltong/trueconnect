import 'package:cloud_firestore/cloud_firestore.dart';

// interface 
abstract class FS_QUERY_INT {

  Future<List<Map<String, dynamic>>> executeQuery(Firestore databaseReference,int limit) async {
  }

}