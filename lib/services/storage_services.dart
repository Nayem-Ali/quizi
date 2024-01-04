import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class StorageService{

  ImagePicker imagePicker = ImagePicker();
  String imageUrl = "";
  late File selectedPhoto;

  selectPhoto() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (file == null) {
      return;
    } else {
      selectedPhoto = File(file.path);

    }
  }


}