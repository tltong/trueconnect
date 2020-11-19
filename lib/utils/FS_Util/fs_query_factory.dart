import 'fs_where_int.dart';
import 'fs_query_int.dart';
import 'fs_query_equal.dart';


class FS_QUERY_FACTOR{

static FS_QUERY_INT createQUERY (String collection, List<FS_WHERE_INT> fshwerelist, String orderby){

  if (fshwerelist.length==1){
    FS_WHERE_INT whereint = fshwerelist[0];

    if (whereint.runtimeType.toString()=='FS_WHERE_EQUAL'){

      FS_QUERY_EQUAL ret = FS_QUERY_EQUAL(collection,whereint,orderby);
      return ret;
    }

  }


}




}