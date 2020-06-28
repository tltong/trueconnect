import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../data/venue/venue.dart';
import '../../data/venue/venue_factory.dart';
import '../../data/imageobject/image_mediator.dart';
import './venue_settings_tabs.dart';
import './venue_settings_photos.dart';


class VenuePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VenuePageState();
  }
  
}

class VenuePageState extends State<VenuePage>{

ImageMediator pgImgMediator;
List child;


// return values
List<Image> images;
List<Image> retImage;

@override
  void initState() {
//    print('venue_page : initstate');
    super.initState();
  }

@override
  void dispose() {
 //   print('venue_page : dispose');
     super.dispose();
   }

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

Widget _Dialog(BuildContext context, Image displayImage) {
    return new AlertDialog(
      //title: const Text('About Pop up'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          displayImage,
          //Image.asset('images/addphoto.png'),
        ],
      )
    );
}

List _initialiseChild(BuildContext context, List<Image> inImages){

//print('venue_page : initialiseChild');

//if (retImage!=null)
//print('venue_page : retImage length at start of initialiseChild: ' + retImage.length.toString());

List<Image> imageslocal = new List<Image>();


//if (retImage!=null)
//print('venue_page : retImage length in the 1st middle part of initialiseChild: ' + retImage.length.toString());


for (int i=0;i<inImages.length;i++){
  imageslocal.add(inImages[i]);
}
//print('venue_page : initialiseChild; imageslocal length : ' + imageslocal.length.toString());
//imageslocal=inImages;


if (imageslocal.length==0) imageslocal.add(Image.asset('images/no-image.png'));


//if (retImage!=null)
//print('venue_page : retImage length in the 2nd middle part of initialiseChild: ' + retImage.length.toString());


List child = map<Widget>(
  imageslocal,
  (index, i) {
    return 
    GestureDetector(
       onTap: () {
              showDialog(
            context: context,
            builder: (BuildContext contextcopy) => _Dialog(contextcopy,i),
          );

            },
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
            i,
  

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              
            ),
          ),
        ]),
      ),
    )

    );
    
  },
).toList();

//if (retImage!=null)
//print('venue_page : retImage length at end of initialiseChild: ' + retImage.length.toString());

//print('venue_page : initialiseChild; this.child length : '+child.length.toString());

return child;

}



@override
  Widget build(BuildContext context) {

  //print('venue_page : build');
 // if (retImage !=null)
 //   print('venue_page : retImage length : ' + retImage.length.toString());


      //ImageMediator imgMediator=ModalRoute.of(context).settings.arguments;


     // pgImgMediator = imgMediator;

      List<Image> argImages = ModalRoute.of(context).settings.arguments;


      List<Image> inImages;

      if (retImage==null){
       // inImages = imgMediator.getImages();
        inImages = argImages;
   //     print('venue_page : inImages reset from imgMediator. length : ' + inImages.length.toString());
      }else{
        inImages=retImage;
     //   print('venue_page : inImages updated with retImage. length : ' + inImages.length.toString());
      }
    if (this.child==null){
      

      List images=_initialiseChild(context, inImages);
      this.child=images;
    }
   
  return 
        
   WillPopScope(
    onWillPop: () async {
     //     print('venue_page : willpopscope');
          /*
          if (inImages!=null)
           print('venue page : inImages length : ' + inImages.length.toString());

          if (retImage!=null)
            print('venue page : retImage length : ' + retImage.length.toString());
          */
          //Navigator.pop(context, pgImgMediator);
          Navigator.pop(context, inImages);
          return false;
        },
    child: 
     
     new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Venue",
          style: new TextStyle(color: Colors.white),
        ),
      ),
       floatingActionButton: FloatingActionButton(
      onPressed: () async {
          

      retImage = await
 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VenueSettingsTabs(inImages)),
        );

//      print('venue_page : returned length from navigator pop : '+ retImage.length.toString());

      inImages=retImage;
      

  //  print('return value at venue_page : ' + retImage.length.toString());

  setState(() {

  //  print('venue_page : initialisechild with retImage; retImage length : ' + retImage.length.toString());
    this.child=_initialiseChild(context, retImage);
  //  print('venue_page : after initialisechild; retImage length : ' + retImage.length.toString());
  
  });
  
      },
      child: const Icon(Icons.edit),
    ),
      body: ListView(

        children:
        [
          CarouselSlider(

      items: child,
      
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    ),


       RaisedButton(
             onPressed: () 

             async {
                
                

                setState(() {

           //       print('rebuild widget : ' + this.child.length.toString());

                });
    
               },
            child: Text('Test'),
           ),
        ]
      )
    ),  


  );
  }

}