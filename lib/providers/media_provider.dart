import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaProvider extends ChangeNotifier {
  XFile? image;
  Uint8List? bytes;
  bool isLoading = false;

  void setImage() async {
    isLoading = true;
    notifyListeners();
    final picker = ImagePicker();
    final raw = await picker.pickVideo(source: ImageSource.gallery); //it was pickImage
    image = raw;
    bytes = await raw!.readAsBytes();
    isLoading = false;
    notifyListeners();
  }

  void reset() {
    image = null;
    bytes = null;
    isLoading = false;
    notifyListeners();
  }
}