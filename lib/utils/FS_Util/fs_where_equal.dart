import './fs_where_int.dart';

class FS_WHERE_EQUAL extends FS_WHERE_INT{

  String field;
  String value;
  
  FS_WHERE_EQUAL(String infield, String invalue){
    field = infield;
    value = invalue;
  }

  void test(){
     print (FS_WHERE_EQUAL);
   }


}