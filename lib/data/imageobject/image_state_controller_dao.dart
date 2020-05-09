import 'package:trueconnect/data/imageobject/image_state.dart';
import './image_state_controller.dart';

class ImageStateControllerDao {

  List<ImageStateController> controllers;

  // constructor
  ImageStateControllerDao(){
    controllers = new List<ImageStateController>();
  }

  bool isEqual(ImageStateControllerDao dao){
    List<ImageStateController> controllers1 = controllers;
    List<ImageStateController> controllers2 = dao.getAllControllers();

    if (controllers.length!=controllers2.length)
      return false;

    bool ret=true;

    for (int i=0;i<controllers1.length;i++){
      bool test;
      test = controllers1[i].isEqual(controllers2[i]);
      if (test==false){
        ret=false;
        break;
      }
    }

    return ret;
  }

  void addController(ImageStateController inController){
    controllers.add(inController);
  }

  List<Map> serialise(){
    List<Map> serialisedControllers = new List<Map>();

    for (ImageStateController controller in controllers){
      Map serialisedController = controller.serialise();
     
      serialisedControllers.add(serialisedController);
    }
    return serialisedControllers;

  }

  List<ImageStateController> getAllControllers(){
    return controllers;
  }

  ImageStateController getController(String id){
    ImageStateController ret=null;
     for (int i=0;i<controllers.length;i++){
      if(controllers[i].toString()==id){
        ret=controllers[i];
      }
    }
    return ret;
  }

  List<ImageStateController> getDisplayControllers(){

    List<ImageStateController> retControllers = new List<ImageStateController>();

    for (int i=0;i<controllers.length;i++){
      ImageState state = controllers[i].getState();
      if (state.runtimeType.toString()=='NetworkImageState' ||state.runtimeType.toString()=='FileImageState'){
        retControllers.add(controllers[i]);
      }
    }
    return retControllers;
  }

  Future<void> processControllers() async {

    for (int i=0;i<controllers.length;i++){
      ImageState state = controllers[i].getState();
      await state.doProcessing(controllers[i]);
    }

    List<ImageStateController> updatedControllers = new List<ImageStateController>();

    for (int i=0;i<controllers.length;i++){
      ImageState state = controllers[i].getState();
      if (state.runtimeType.toString()=='NetworkImageState' ||state.runtimeType.toString()=='FileImageState'){
        updatedControllers.add(controllers[i]);
      }
    }
    controllers=updatedControllers;
  }

  void removeController(ImageStateController inController){

    int id;
    bool match=false;
    for (int i=0;i<controllers.length;i++){
      if(controllers[i].toString()==inController.toString()){
        id=i;
        match=true;
      }
    }
    if (match==true){
      controllers.removeAt(id);
    }
  }
}