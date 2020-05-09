import 'package:flutter/material.dart';
import 'package:trueconnect/data/imageobject/image_fileimage_state.dart';
import 'package:trueconnect/data/imageobject/image_networkimage_state.dart';
import 'package:trueconnect/data/imageobject/image_object.dart';
import 'package:trueconnect/data/imageobject/image_state.dart';
import 'package:trueconnect/data/imageobject/image_state_controller.dart';
import 'package:trueconnect/data/imageobject/image_state_controller_dao.dart';
import 'package:trueconnect/utils/appdata.dart';
import '../utils/fs_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../user.dart';
import '../utils/image_util.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../data/image_struct.dart';
import '../data/imageobject/image_mediator.dart';
import 'dart:math';

import '../data/venue/venue.dart';
import '../data/venue/venue_factory.dart';
import '../data/venue/venue_dao.dart';
import '../data/common_strings.dart';


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
Image image1,image2;
ImageObject imageobject1, imageobject2;

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
    
        RaisedButton(
             onPressed: () async {
          
               List<ImageStruct> photos;
               
            await ImageUtil.pickImageFromGallery().then((ret) async {  // returns a file
                  Image image = Image.file(ret);

                  var rng = new Random();
                  int index = rng.nextInt(100000);  
       
                  String path = 'venuephotos/'+index.toString();
                 
                  ImageStruct imagestruct = new ImageStruct(image,path,null);

                  List<ImageStruct> inimages = new List<ImageStruct>();
                  inimages.add(imagestruct);

                });

            print('next to upload data');

                Venue venue = VenueFactory.CreateVenue(photos, 'asia square', '12 Marina View, Singapore 018961',null, null, null);
             
                VenueDao vdao = new VenueDao(venue);

                await vdao.upload().then((id){
                    print('database updated');
                });


               },
            child: Text('Test venue upload'),
           ),

           RaisedButton(
             onPressed: () async {

                  await ImageUtil.pickImageFromGallery().then((ret) async {  // returns a file
                  image1 = Image.file(ret);

                  //Step 1 : create image object
                  imageobject1 = new ImageObject(image1, null, null);
                
                  //Step 2 : create state object
                  ImageState imagestate = new FileImageState(imageobject1);                 
                  
                  //Step 3 : create image controller
                  ImageStateController statecontroller = new ImageStateController(imagestate);

                  //Step 4 : create controllerdao and add controller
                  ImageStateControllerDao statedao = new ImageStateControllerDao();
                  statedao.addController(statecontroller);

                  //Step 5 : upload photo
                  statedao.processControllers().then((id){
                    print('upload done');

                    //Step 6 : check serialised data
                    List<Map> serialisedData = statedao.serialise();
                    print('serialised data :');
                    print(serialisedData);

                  });



                });
               },
            child: Text('Get Image 1'),
           ),
      
            RaisedButton(
             onPressed: () async {

                  await ImageUtil.pickImageFromGallery().then((ret) async {  // returns a file
                  image2 = Image.file(ret);

                  List<Image> imageList = new List<Image>();
                  imageList.add(image2);

                  ImageMediator mediator = new ImageMediator(imageList);
                  List<Image> retList = mediator.getImages();
                  for (Image img in retList){
                    print(img.toString());
                  }
                });
               },
            child: Text('Get Image 2'),
           ),

                    RaisedButton(
             onPressed: () async {
                           


               },
            child: Text('Test stuff'),
           ),

           
    
    ]),
   
      
    );
  }
  
} 



