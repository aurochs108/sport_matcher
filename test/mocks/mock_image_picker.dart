import 'package:image_picker/image_picker.dart';

class MockImagePicker extends ImagePicker {
  MockImagePicker();

  XFile? pickedImageReturnValue;

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    return pickedImageReturnValue;
  }
}