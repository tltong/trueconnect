import 'package:flutter/material.dart';
import 'package:trueconnect/data/imageobject/image_networkimage_state.dart';
import 'package:trueconnect/data/imageobject/image_object.dart';
import './image_state.dart';
import './image_state_controller.dart';
import '../../utils/fs_util.dart';
import '../../utils/image_util.dart';

class MemoryImageState extends ImageState{

  // constructor
  MemoryImageState(ImageObject inImageObject){
    this.imageobject=inImageObject;
  }

  @override
  Future<void> doProcessing(ImageStateController controller) async {
    // TODO : firestore upload
  }


}