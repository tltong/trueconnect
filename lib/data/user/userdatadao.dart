import 'userdata.dart';
import '../../utils/fs_util.dart';
import 'package:trueconnect/utils/FS_Util/fs_query_factory.dart';
import 'package:trueconnect/utils/FS_Util/fs_query_int.dart';
import 'package:trueconnect/utils/FS_Util/fs_where_int.dart';


class UserDataDao {

  static final String USER_COLLECTION = 'users';
  static final String USER_COLLECTION_ORDERBY = 'last_name';

  UserDataDao();
  FS_QUERY_INT query;

  initialiseQuery(List<FS_WHERE_INT> infswhereintlist){

    query = FS_QUERY_FACTOR.createQUERY(USER_COLLECTION, infswhereintlist, USER_COLLECTION_ORDERBY);

  }


  static Future<String> uploadRecord(UserData udata) async {

    Map<String, dynamic> udata_upload = new Map<String, dynamic>();

    udata_upload.putIfAbsent("id", ()=> udata.id);
    udata_upload.putIfAbsent("name", ()=> udata.name);
    udata_upload.putIfAbsent("email", ()=> udata.email);
    udata_upload.putIfAbsent("first_name", ()=> udata.first_name);
    udata_upload.putIfAbsent("last_name", ()=> udata.last_name);

    FS_Util fs = new FS_Util();

    String id = await fs.addRecord(USER_COLLECTION, udata_upload);

    return id;
  }

   Future<List<UserData>> fetchUserData(int limit) async {

    FS_Util fs = new FS_Util();
    var doc = await query.executeQuery(fs.databaseReference, limit);

    List<UserData> ret = new List<UserData>();

      for(int i=0;i<doc.length;i++){

        Map<String,dynamic> entry = doc[i];
        UserData udata = UserData.Direct(entry['id'],entry['name'],entry['email'],entry['first_name'],entry['last_name']);
        ret.add(udata);
    }
   return ret; 

  }

}