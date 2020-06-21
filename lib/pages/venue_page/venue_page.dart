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
List<Image> images;

@override
  void initState() {
    super.initState();
  }

@override
  void dispose() {
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

List<Image> imageslocal;

imageslocal=inImages;
if (imageslocal.length==0) imageslocal.add(Image.asset('images/no-image.png'));

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

return child;

}



@override
  Widget build(BuildContext context) {

  ImageMediator imgMediator=ModalRoute.of(context).settings.arguments;
  pgImgMediator = imgMediator;

  List<Image> inImages = imgMediator.getImages();


  List images=_initialiseChild(context, inImages);


  this.child=images;

        return WillPopScope(
    onWillPop: () async {
           Navigator.pop(context, pgImgMediator);
          return false;
        },
    child: new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Venue",
          style: new TextStyle(color: Colors.white),
        ),
      ),
       floatingActionButton: FloatingActionButton(
      onPressed: () {
          Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VenueSettingsTabs(inImages)),
        );
      },
      child: const Icon(Icons.edit),
    ),
      body: ListView(

        children:
        [
          
          new CarouselSlider(

      items: child,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    ),
       RaisedButton(
             onPressed: () 

             async {
                List<Image> imgList = imgMediator.getImages();
                for (Image image in imgList){
                  print (image.toString());
                }
    
               },
            child: Text('Test'),
           ),
        ]
      )
      
      
     
    ),
  );



  }

}