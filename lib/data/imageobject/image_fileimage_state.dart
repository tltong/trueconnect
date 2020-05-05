import 'package:flutter/material.dart';
import 'package:trueconnect/data/imageobject/image_networkimage_state.dart';
import 'package:trueconnect/data/imageobject/image_object.dart';
import './image_state.dart';
import './image_state_controller.dart';
import '../../utils/fs_util.dart';
import '../../utils/image_util.dart';

class FileImageState extends ImageState{
  

  // constructor
  FileImageState(ImageObject inImageObject){
    this.imageobject=inImageObject;
  }

  @override
  Future<void> doProcessing(ImageStateController controller) async {
    FS_Util fs = new FS_Util();

    await fs.uploadFile(imageobject.uploadpath,ImageUtil.FileFromImage(imageobject.image)).then((downloadlink)
      {
          imageobject.downloadlink = downloadlink;
          imageobject.image = ImageUtil.NetworkImageFromLink(downloadlink);

          NetworkImageState newstate = new NetworkImageState(imageobject);
          controller.setState(newstate);
      });
  
  }

 
}