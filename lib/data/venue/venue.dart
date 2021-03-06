import 'package:flutter/material.dart';
import '../image_struct.dart';
import '../../data/imageobject/image_mediator.dart';

enum Type { 
   meal, 
   drinks, 
   outdoors, 
   nightlife,
   sports,
   getaway 
} 

class Venue {

    //List<Image> images = new List<Image>();

    List<ImageStruct> imagestructs = new List<ImageStruct>();
    ImageMediator imgMediator;
    
    String name;
    String address;
    String description;
    Type type;
    int splurge;
    String user;
    String id;

    Venue(ImageMediator inimgMediator, String name, String address, String description, Type type, int splurge, String user, String id)
    {
        this.imgMediator=inimgMediator;
        this.name=name;
        this.address=address;
        this.description=description;
        this.type=type;
        this.splurge=splurge;
        this.user=user;
        this.id=id;
    }






    



}