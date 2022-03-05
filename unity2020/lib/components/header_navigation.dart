import 'package:flutter/material.dart';
import 'package:tut/utils/colors_app.dart';
import 'package:tut/utils/constants.dart';
import 'dart:math' as math;

class HeaderNavigation extends StatefulWidget {
  final bool statusGnss;
  final double delocamento;
  final String typeConnection;

  // final bool statusBluetooth;
  const HeaderNavigation(
      {Key key, this.statusGnss, this.delocamento, this.typeConnection

      // required this.statusBluetooth,
      })
      : super(key: key);

  @override
  State<HeaderNavigation> createState() => _HeaderNavigationState();
}

class _HeaderNavigationState extends State<HeaderNavigation> {
  bool left = false;
  bool right = false;
  // todo deixar dinamico
  double direction = 20;

  get delocamento => widget.delocamento;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.10,
      color: ColorsApp.grey32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  flex: isTabletHorizontal(context) ? 1 : 2,
                  child: Container()),
              Expanded(
                  flex: isTabletHorizontal(context) ? 8 : 7,
                  child: setaRota(context)),
              Expanded(
                  flex: isTabletHorizontal(context) ? 1 : 2,
                  child: gnss(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget gnss(context) {
    bool isGnss = false;
    return GestureDetector(
      onTap: () {
        isGnss = !isGnss;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: widget.statusGnss ? ColorsApp.green73 : Colors.red,
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.statusGnss ? 'GNSS' : 'no GNSS',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isTabletHorizontal(context) ? 20 : 12,
                  fontWeight: FontWeight.w400),
            ),
            // if (widget.typeConnection == GpsType.bluetooth)
            //   Icon(Icons.bluetooth, color: Colors.white, size: 15),
            // if (widget.typeConnection == GpsType.usb)
            //   Icon(Icons.usb, color: Colors.white, size: 15),
          ],
        ),
      ),
    );
  }

  List iconLeft = <Widget>[];
  List iconRight = <Widget>[];
  void updateIconLeft<List>() {
    for (var i = 0; i < 10; i++) {
      iconLeft.add(Container(
        width: isTabletHorizontal(context) ? 20 : 15,
        child: Icon(
          Icons.chevron_left,
          color: left ? Colors.green : Colors.grey,
          size: isTabletHorizontal(context) ? 40.0 : 25.0,
        ),
      ));
    }
  }

  void updateIconRight<List>() {
    for (var i = 0; i < 10; i++) {
      iconRight.add(Container(
        width: isTabletHorizontal(context) ? 20 : 15,
        child: Icon(
          Icons.chevron_right,
          color: right ? Colors.green : Colors.grey,
          size: isTabletHorizontal(context) ? 40.0 : 25.0,
        ),
      ));
    }
  }

  formatDeslocametoText() {
    return delocamento > 0 ? delocamento.toStringAsFixed(2) : '* * *';
  }

  Widget setaRota(context) {
    updateIconLeft<List>();
    updateIconRight<List>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < 10; i++) iconRight[i],
        Padding(
          padding: EdgeInsets.only(right: 20, left: 30),
          child: RichText(
            text: TextSpan(
              text: formatDeslocametoText(),
              style: TextStyle(
                  color: Color.fromRGBO(255, 123, 0, 1),
                  fontSize: delocamento > 0 ? 25 : 18,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                if (delocamento > 0)
                  TextSpan(text: ' cm', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
        for (var i = 0; i < 10; i++)
          Stack(
            children: [iconLeft[i]],
          )
      ],
    );
  }
}
