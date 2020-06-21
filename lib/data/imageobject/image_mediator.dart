import 'package:flutter/widgets.dart';
import 'package:trueconnect/data/imageobject/image_fileimage_state.dart';
import 'package:trueconnect/data/imageobject/image_networkimage_state.dart';
import './image_memoryimage_state.dart';
import 'package:trueconnect/data/imageobject/image_networkimagedelete_state.dart';
import 'package:trueconnect/utils/image_util.dart';
import './image_object.dart';
import './image_state.dart';
import './image_state_controller.dart';
import './image_state_controller_dao.dart';

class ImageMediator {

  ImageStateControllerDao currentDao;
  ImageStateControllerDao selectedDao;

  ImageMediator(List<Image> inImages){
    this.currentDao = _constructDao(inImages);
  }


  Future<void> doProcessing() async {

    if (currentDao.isEqual(selectedDao))
      return;

    await selectedDao.processControllers();

    // this is to remove old photos on the network
    List<ImageStateController> oldControllers = currentDao.getAllControllers();
    List<ImageStateController> newControllers = selectedDao.getAllControllers();
    List<ImageStateController> toDeleteControllers = new List<ImageStateController>();

    for (int i=0;i<oldControllers.length;i++){
      bool found;
      for (int j=0;i<newControllers.length;j++){
        if (oldControllers[i].isEqual(newControllers[j])==true){
          found=true;
          break;
        }
      if (found==false){
        if (oldControllers[i].returnStateType()=='NetworkImageState'){
          NetworkImageDeleteState toDelState = new NetworkImageDeleteState(oldControllers[i].getState().imageobject);
          ImageStateController toDelCtrl = new ImageStateController(toDelState);
          toDeleteControllers.add(toDelCtrl);
        }
      }
      }
    }

    ImageStateControllerDao toDelDao = new ImageStateControllerDao();
    for (ImageStateController toDelCtrl in toDeleteControllers){
      toDelDao.addController(toDelCtrl);
    }
    
    await toDelDao.processControllers();

    //after all processing, update currentDao
    currentDao=selectedDao;
    selectedDao=null;    

  }

   List<Image> getImages(){

    ImageStateControllerDao controllerDao;
     if (selectedDao==null){
       controllerDao=currentDao;
     }else{
       controllerDao=selectedDao;
     }

    List<ImageStateController> controllerlist = controllerDao.getDisplayControllers();

    List<ImageState> stateList = new List<ImageState>();

    for (ImageStateController controller in controllerlist){
      ImageState state = controller.getState();
      stateList.add(state);
    }

    List<ImageObject> objList = new List<ImageObject>();

    for (ImageState stateobj in stateList){
      ImageObject imageObj = stateobj.returnImageObject();
      objList.add(imageObj);
    }

    List<Image> retImageList = new List<Image>();

    for (ImageObject obj in objList){
      retImageList.add(obj.image);
    }

    return retImageList;
  }

  // private function - (for file images and network images only)
  ImageStateControllerDao _constructDao(List<Image> inImages){

    List<ImageObject> imgObjList = new List<ImageObject>();
    for (Image img in inImages){
     
      ImageObject imgObj = new ImageObject(img, null, null);
      imgObjList.add(imgObj);
    }

    List<ImageState> stateList = new List<ImageState>();
    for (ImageObject imgObj in imgObjList){
      String imagetype = ImageUtil.Imagetype(imgObj.image);

      if (imagetype == 'FileImage'){
        ImageState imgState = new FileImageState(imgObj);
        stateList.add(imgState);
      }else if (imagetype == 'NetworkImage'){
        ImageState imgState = new NetworkImageState(imgObj);
        stateList.add(imgState);
      }else if (imagetype == 'MemoryImage'){
        ImageState imgState = new MemoryImageState(imgObj);
        stateList.add(imgState);
      }
    }

    List<ImageStateController> controllerlist = new List<ImageStateController>();

    for (ImageState imgState in stateList){
      ImageStateController controller = new ImageStateController(imgState);
      controllerlist.add(controller);
    }

    ImageStateControllerDao dao = new ImageStateControllerDao();
    for (ImageStateController controller in controllerlist){
      dao.addController(controller);
    }

    return dao;
    
  }

  void setSelectedImages(List<Image> inImages){
    this.selectedDao=_constructDao(inImages);
  }

}