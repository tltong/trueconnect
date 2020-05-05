import 'package:flutter/material.dart';
import 'package:trueconnect/data/imageobject/image_object.dart';
import './image_state.dart';
import './image_state_controller.dart';


class NoImageState extends ImageState{

 // constructor
  NoImageState(ImageObject inImageObject){
    this.imageobject=inImageObject;
  }

  @override
  Future<void> doProcessing(ImageStateController controller) async {
    // do nothing
  }

}