

import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';







class ImagePickerService {
  final ImagePicker _picker = ImagePicker();


  Future<Uint8List?> pickFromCamera({int imageQuality = 80}) async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );
    if (picked == null) return null;
    return picked.readAsBytes();
  }


  Future<Uint8List?> pickFromGallery({int imageQuality = 80}) async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
    if (picked == null) return null;
    return picked.readAsBytes();
  }
}