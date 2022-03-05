import 'dart:convert';

import 'package:flutter/material.dart';

convertImageBase64(_file) {
  String base64Image = "";
  //Converte _file para base64
  if (_file != null) {
    print("image");
    print(_file.toString());
    String fileName = _file.path.split('/').last;
    print(fileName);

    var ext = fileName.split('.').last;
    print(ext);

    List<int> imageBytes = _file.readAsBytesSync();
    print(imageBytes);
    base64Image = "data:image/$ext;base64," + base64Encode(imageBytes);
  }
  print("base64");
  print(base64Image);
  return base64Image;
}

isTablet(context) {
  double widthTotal = MediaQuery.of(context).size.width;
  // print('isTablet ' + widthTotal.toString());
  if (widthTotal < 600) {
    return false;
  } else {
    return true;
  }
}

isTabletHorizontal(context) {
  double widthTotal = MediaQuery.of(context).size.width;
  // print('isTabletHorizontal' + widthTotal.toString());
  if (widthTotal < 860) {
    return false;
  } else {
    return true;
  }
}

isTabletAll(context) {
  if (isTabletHorizontal(context) == true || isTablet(context) == true) {
    return true;
  } else {
    return false;
  }
}
