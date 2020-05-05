import './image_state_controller.dart';

class ImageStateControllerDao {

  List<ImageStateController> controllers;

  ImageStateControllerDao(){
    controllers = new List<ImageStateController>();
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