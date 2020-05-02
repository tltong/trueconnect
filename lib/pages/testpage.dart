import 'package:flutter/material.dart';
import 'package:trueconnect/utils/appdata.dart';
import '../utils/fs_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../user.dart';
import '../utils/image_util.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../data/image_struct.dart';
import 'dart:math';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestPageState();
  }
}

class TestPageState extends State<TestPage>{


final Widget placeholder = Container(color: Colors.grey);


BuildContext contextcopy;

ProgressDialog buildProgressDialog(){

  ProgressDialog pr;
  pr = new ProgressDialog(context, type:ProgressDialogType.Normal, isDismissible:false);
    pr.style(
         
          message: 'Please Wait',
          borderRadius: 5.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 5.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
        );
  return pr;
}

@override
  void initState() {
   
 
    super.initState();

  }

@override
  void dispose() {
    super.dispose();
 
  }

 @override
  Widget build(BuildContext context) {
    contextcopy=context;

 return Scaffold(
      appBar: AppBar(
        title: Text("Test page"),
      ),

      body: 
        ListView(
          
    children:
    [
      
            RaisedButton(
             onPressed: () {
               ProgressDialog pgd = buildProgressDialog();
               pgd.show();
               Future.delayed(Duration(seconds: 3)).then((value){
                 pgd.hide().whenComplete((){ });
               });
               },
            child: Text('Test progress dialog'),
           ),

           RaisedButton(
             onPressed: () {
                ImageUtil.pickImageFromGallery().then((ret){  // returns a file
                  Image image = Image.file(ret);

                  var rng = new Random();
                  int index = rng.nextInt(100000);  
       
                  String path = 'testphotos/'+index.toString();
                 
                  ImageStruct imagestruct = new ImageStruct(image,path,null);

                  List<ImageStruct> inimages = new List<ImageStruct>();
                  inimages.add(imagestruct);

                  ImageUtil.uploadImages(inimages).then((id){
                    print(id[0].downloadlink);
                  });



                });
               },
            child: Text('Test image upload'),
           ),
    

      
            
            

     
    
    ]),
   
      
    );
  }
  
} 



