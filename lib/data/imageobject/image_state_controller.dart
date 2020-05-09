import './image_state.dart';


class ImageStateController {

  ImageState imagestate;

  ImageStateController(ImageState inState){
    this.imagestate=inState;
  }

  void setState(ImageState inState){
    this.imagestate=inState;
  }

  ImageState getState(){
    return this.imagestate;
  }

  String returnStateType(){
    return imagestate.returnStateType();
  }

  String returnID (){
    return imagestate.returnID();
  }

  bool isEqual(ImageStateController inCtrl){
    
    ImageState state = inCtrl.getState(); 
    return imagestate.isEqual(state);
  }

  Map serialise(){
    return imagestate.imageobject.serialise();
  }

  
  
}