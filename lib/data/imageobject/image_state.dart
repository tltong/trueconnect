import './image_object.dart';
import './image_state_controller.dart';


// interface 
abstract class ImageState {

  ImageObject imageobject;
  
  Future<void> doProcessing(ImageStateController controller) async {
  }

  ImageObject returnImageObject(){
    return this.imageobject;
  }

  String returnStateType(){
    return this.runtimeType.toString();
  }

  bool isUploaded(){
    if (imageobject.downloadlink!=null)
      return true;
    else
      return false;
  }

  bool isEqual(ImageState inState){
    ImageObject obj1 = imageobject;
    ImageObject obj2 = inState.returnImageObject();

    bool ret=true;

    if (obj1.IsEqual(obj2)==false){
      ret=false;
    }
/*
    if (this.runtimeType!=inState.runtimeType){
      ret=false;
    }
*/
    return ret;
  }

  String returnID(){
    return imageobject.returnID();
  }

}