import 'package:trueconnect/data/imageobject/image_object.dart';
import './image_state.dart';
import './image_state_controller.dart';
import './image_noimage_state.dart';
import '../../utils/fs_util.dart';
import './image_noimage_state.dart';

class NetworkImageDeleteState extends ImageState{

  // constructor
  NetworkImageDeleteState(ImageObject inImageObject){
    this.imageobject=inImageObject;
  }

  @override
  Future<void> doProcessing(ImageStateController controller) async {
    // delete from online FS db

    FS_Util fs = new FS_Util();

    await fs.deleteFile(imageobject.uploadpath).then((id){
      NoImageState state = new NoImageState(null);
      controller.setState((state));
      
    });


  }

}