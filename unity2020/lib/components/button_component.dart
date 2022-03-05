import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors_app.dart';

class ButtonComponents {
  static buttonOutlined(
      {String text,
      colorText,
      colorBorder,
      padding = 13.0,
      font = 17.0,
      radius = 30.0,
      action}) {
    return OutlinedButton(
        onPressed: action,
        style: OutlinedButton.styleFrom(
          elevation: 2.0,
          primary: Colors.transparent,
          backgroundColor: Colors.transparent,
          textStyle: TextStyle(color: colorText, fontSize: 15),
          side: BorderSide(color: colorBorder, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.only(top: padding, bottom: padding),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: colorText, fontSize: font, fontWeight: FontWeight.w600),
        ));
  }

  static button({
    text = "",
    colorText = Colors.white,
    colorBg = ColorsApp.blue,
    padding = 16.0,
    font = 17.0,
    radius = 30.0,
    action,
  }) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        elevation: 2.0,
        primary: colorBg,
        textStyle: TextStyle(color: colorText, fontSize: font),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(radius),
          side: BorderSide(color: colorBg),
        ),
        padding: EdgeInsets.only(top: padding, bottom: padding),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: colorText, fontSize: font, fontWeight: FontWeight.w600),
      ),
    );
  }

  static buttonCircleIcon({
    String icon,
    iconSize = 35.0,
    iconColor = Colors.white,
    colorBg = ColorsApp.blue,
    size = 94.0,
    font = 17.0,
    radius = 30.0,
    action,
  }) {
    return RawMaterialButton(
      onPressed: action,
      constraints: BoxConstraints.tight(Size(size, size)),
      elevation: 2.0,
      fillColor: colorBg,
      shape: CircleBorder(),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: iconSize,
          color: iconColor,
        ),
      ),
    );
  }

  static buttonCircleBorder({
    Widget content,
    colorBg = ColorsApp.blue,
    colorBorder = ColorsApp.blue,
    sizeBorder = 10.0,
    size = 94.0,
    action,
  }) {
    return RawMaterialButton(
        constraints: BoxConstraints.tight(Size(size, size)),
        onPressed: action,
        elevation: 2.0,
        fillColor: colorBg,
        // padding: EdgeInsets.all(padding),
        shape: CircleBorder(
          side: BorderSide(width: sizeBorder, color: colorBorder),
        ),
        child: content);
  }
}
