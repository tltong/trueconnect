import './image_state.dart';


class ImageStateController {

  ImageState imagestate;

  void setState(ImageState inState){
    this.imagestate=inState;
  }

  ImageState returnState(){
    return this.imagestate;
  }

  String returnID (){
    return imagestate.returnID();
  }

  Map serialise(){
    return imagestate.imageobject.serialise();
  }

  
  
}