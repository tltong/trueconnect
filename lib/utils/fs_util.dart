import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FS_Util{

  final databaseReference = Firestore.instance;


  void createRecord(String collection, String field, String value) async {

      DocumentReference ref = await databaseReference.collection(collection)
      .add({
        field: value,
      });
    print("saving to fs" + ref.documentID);
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