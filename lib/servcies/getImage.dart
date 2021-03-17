import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();
///-----------------------------------------------------------------------------

Future<String> getImageFromCamera() async {
  var image = await picker.getImage(source: ImageSource.camera);
  return image.path;
}

Future<String> getImageFromGallery() async {
  var image = await picker.getImage(source: ImageSource.gallery);
  return image.path;
}