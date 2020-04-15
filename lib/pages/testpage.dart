import 'package:flutter/material.dart';
import 'package:trueconnect/utils/appdata.dart';
import '../utils/fs_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../user.dart';
import '../utils/image_util.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestPageState();
  }
}

class TestPageState extends State<TestPage>{

Photos photos;
static List<Image> images;
static List<String> imageLinks;


static List<T> map<T>(List list, Function handler) {
  List<T> result = [];
 
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
 
  return result;
}


final Widget placeholder = Container(color: Colors.grey);

List child;
BuildContext contextcopy;

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


void initialiseChild(){

child = map<Widget>(
  images,
  (index, i) {
    return 
    GestureDetector(
       onTap: () {
              showDialog(
            context: contextcopy,
            builder: (BuildContext contextcopy) => _Dialog(contextcopy,i),
          );

            },
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
            i,
         // Image.network(i, fit: BoxFit.scaleDown, width: 1000.0),

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

}

@override
  void initState() {
   
    photos = appData.currentUser.getPhotos();
    images = appData.currentUser.photos.getSelectedPhotos();
    imageLinks = new List<String>();

    for (Image image in images){  
      String imgstring = ImageUtil.ExtractImageString(image);
      imageLinks.add(imgstring);
    }
  // print(imageLinks);



initialiseChild();
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
      
     new CarouselSlider(
      items: child,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    ),

      
            
            

     
    
    ]),
   
      
    );
  }
  
} 



