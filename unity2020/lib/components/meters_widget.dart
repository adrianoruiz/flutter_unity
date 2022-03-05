import 'package:flutter/material.dart';

import 'package:tut/utils/colors_app.dart';
import 'package:tut/utils/constants.dart';

class MetersWidget extends StatelessWidget {
  final String textVelocidade;
  final String areaPercoridaHa;
  final String areaPercorida;
  final double sat;
  final double dop;

  const MetersWidget({
    Key key,
    this.textVelocidade,
    this.areaPercoridaHa,
    this.areaPercorida,
    this.sat,
    this.dop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          haMeditor(context),
          // satIndicator(context),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // haMeditor(context),
          satIndicator(context),
        ],
      )
    ]);
  }

  Widget haMeditor(context) {
    return Container(
        margin: EdgeInsets.only(right: 60),
        height: isTabletHorizontal(context) ? 70 : 60,
        padding: EdgeInsets.only(right: 100, left: 10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(175, 100, 88, 0.84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              areaPercoridaHa + ' ha',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isTabletHorizontal(context) ? 24 : 14,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              areaPercorida + ' m',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isTabletHorizontal(context) ? 24 : 14,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget satIndicator(context) {
    return Container(
      height: isTabletHorizontal(context) ? 70 : 60,
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          color: ColorsApp.dark25,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sats: ${sat == 0 ? '--' : sat}  DOP:  ${dop == 0 ? '--' : dop}',
            style: TextStyle(
                color: Colors.white,
                fontSize: isTabletHorizontal(context) ? 16 : 14,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
          Text(
            textVelocidade,
            style: TextStyle(
                color: Colors.white,
                fontSize: isTabletHorizontal(context) ? 20 : 14,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
