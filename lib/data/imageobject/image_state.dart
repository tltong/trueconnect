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

  bool isUploaded(){
    if (imageobject.downloadlink!=null)
      return true;
    else
      return false;
  }

  String returnID(){
    return imageobject.returnID();
  }

}