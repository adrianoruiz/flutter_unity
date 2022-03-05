import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:tut/main.dart';
import 'package:tut/utils/colors_app.dart';
import 'package:tut/utils/constants.dart';
import 'dart:async';
import 'components/button_component.dart';
import 'components/header_navigation.dart';
import 'components/meters_widget.dart';

class UnityTestingWrapper extends StatefulWidget {
  UnityTestingState createState() => UnityTestingState();
}

class UnityTestingState extends State<UnityTestingWrapper> {
  UnityWidgetController _unityWidgetController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  double delocamento = 0;
  void unitySetSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Tractor',
      'setSpeed',
      speed,
    );
  }

  void unitySetTrailVisibility(String visible) {
    _unityWidgetController.postMessage(
      'Implement',
      'setTrailVisibility',
      visible,
    );
  }

  void unitySetImplementWidth(String width) {
    _unityWidgetController.postMessage(
      'Implement',
      'setImplementWidth',
      width,
    );
  }

  void unitySetLineVisibility(String visible) {
    _unityWidgetController.postMessage(
      'Tractor',
      'spawnLines',
      visible,
    );
  }

  double rotateValue = 20;

  void unitySetTractorRotate(double angle) {
    print('setTractorRotate: $angle');

    _unityWidgetController.postMessage(
      'Tractor',
      'setTractorRotate',
      angle.toString(),
    );
  }

  int zoom = 45;
  Timer mytimer;
  int times = 1;

  void _zoomIn() {
    mytimer = Timer.periodic(Duration(milliseconds: 40), (Timer timer) {
      if (zoom > 14) {
        zoom--;
        unityCallZoom();
      } else {
        mytimer.cancel();
      }
    });
  }

  void unityCallZoom() {
    times++;
    if (times == 10) {
      mytimer.cancel();
    }
    _unityWidgetController.postMessage(
      'VirtualCam',
      'zoom',
      zoom.toString(),
    );
  }

  void _zoomOut() {
    print("_zoomOut $zoom - $times");
    mytimer = Timer.periodic(Duration(milliseconds: 40), (Timer timer) {
      if (zoom < 108) {
        zoom++;
        unityCallZoom();
      } else {
        mytimer.cancel();
      }
    });
  }

  void unityZoom(String zoomType) {
    times = 0;
    if (zoomType == 'zoomIn') {
      _zoomIn();
    } else {
      _zoomOut();
    }
  }

  // Todo implmentar
  void unitySetPointA(String angle) {
    _unityWidgetController.postMessage(
      'Tractor',
      'spawnLines',
      angle,
    );
  }

  // Todo implmentar
  void unitySetPointB(String angle) {
    _unityWidgetController.postMessage(
      'PoinB',
      'spawnLines',
      angle,
    );
  }

  // Todo implmentar
  void unitySetImplementdistance(String distance) {
    _unityWidgetController.postMessage(
      'PoinB',
      'spawnLines',
      distance,
    );
  }

  // var criado por Adriano
  double speed = 0;
  bool played = false;
  double areaPercoridaHa = 0;
  double areaPercorida = 0;
  String trailVisibility = "n";
  double implementWidth = 10;

  void stop() {
    played = false;
    speed = -1;
    unitySetSpeed(speed.toString());
  }

  void setPlayed() {
    played = true;
    speed = 280;

    unitySetSpeed(speed.toString());
    // unitySetTrailVisibility(trailVisibility);
    unitySetImplementWidth(implementWidth.toString());

    // setPlayed(true);
  }

/* instaciar o unity */

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  onUnityMessage(message) {
    print('From unity: $message');
    setState(() {
      delocamento = double.parse(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: structure()),
    );
  }

  Widget structure() {
    return Stack(
      children: [
        Expanded(
          flex: 13,
          child: Container(
              margin: EdgeInsets.only(top: 38),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: backgroundFullWidth()),
        ),
        Expanded(
          flex: isTabletHorizontal(context) ? 3 : 4,
          // child: Text('HeaderNavigation')
          child: HeaderNavigation(
              statusGnss: true,
              delocamento: delocamento,
              typeConnection: 'bluetooth'),
        )
      ],
    );
  }

  Widget backgroundFullWidth() {
    return Stack(
      children: <Widget>[
        UnityWidget(
          onUnityCreated: onUnityCreated,
          onUnityMessage: onUnityMessage,
          fullscreen: false,
        ),
        controls(),
      ],
    );
  }

  Widget butB() {
    return ButtonComponents.buttonCircleBorder(
        content: Text(
          'B',
          style: TextStyle(
              color: ColorsApp.grey90,
              fontSize: isTabletHorizontal(context) ? 50 : 20,
              fontWeight: FontWeight.bold),
        ),
        size: isTabletHorizontal(context) ? 94.0 : 54.0,
        sizeBorder: isTabletHorizontal(context) ? 10.0 : 5.0,
        colorBg: ColorsApp.grey200,
        colorBorder: ColorsApp.grey38Alpha,
        action: () {
          stop();
        });
  }

  Widget butA() {
    return ButtonComponents.buttonCircleBorder(
        content: Text(
          'A',
          style: TextStyle(
              color: ColorsApp.grey90,
              fontSize: isTabletHorizontal(context) ? 50 : 20,
              fontWeight: FontWeight.bold),
        ),
        size: isTabletHorizontal(context) ? 94.0 : 54.0,
        sizeBorder: isTabletHorizontal(context) ? 10.0 : 5.0,
        colorBg: ColorsApp.grey200,
        colorBorder: ColorsApp.grey38Alpha,
        action: () => unitySetSpeed(speed.toString()));
  }

  Widget controls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: buttonLeft()),
        Expanded(flex: 6, child: buttonTest()),
        Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: isTabletHorizontal(context) ? 10 : 0,
                  top: isTabletHorizontal(context) ? 15 : 10),
              child: buttonsRight(),
            )),
      ],
    );
  }

  double angleTractorRight = 0;
  double angleTractorLeft = 0;

  Widget buttonTest() {
// teste deltar depois
    return Row(
      children: [
        ButtonComponents.buttonCircleBorder(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Left',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsApp.grey90,
                    fontSize: isTabletHorizontal(context) ? 18 : 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          size: isTabletHorizontal(context) ? 94.0 : 54.0,
          sizeBorder: isTabletHorizontal(context) ? 10.0 : 5.0,
          colorBg: ColorsApp.grey200,
          colorBorder: ColorsApp.grey38Alpha,
          action: () {
            if (rotateValue == 20) {
              rotateValue = 0;
            } else {
              rotateValue = -20;
            }

            unitySetTractorRotate(rotateValue);
          },
        ),
        ButtonComponents.buttonCircleBorder(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Right',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsApp.grey90,
                    fontSize: isTabletHorizontal(context) ? 18 : 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          size: isTabletHorizontal(context) ? 94.0 : 54.0,
          sizeBorder: isTabletHorizontal(context) ? 10.0 : 5.0,
          colorBg: ColorsApp.grey200,
          colorBorder: ColorsApp.grey38Alpha,
          action: () {
            if (rotateValue == -20) {
              rotateValue = 0;
            } else {
              rotateValue = 20;
            }
            unitySetTractorRotate(rotateValue);
          },
        ),
      ],
    );
    //
  }

  Widget buttonLeft() {
    return ListView(
      //voltar para column depois que eliminar alguns botoes
      children: [
        //compass

        buttonsSpaceBetween(),
        ButtonComponents.buttonCircleIcon(
          icon: "assets/svg/home.svg",
          colorBg: ColorsApp.grey38Alpha,
          size: isTabletHorizontal(context) ? 94.0 : 54.0,
          iconSize: isTabletHorizontal(context) ? 35.0 : 20.0,
          action: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
        buttonsSpaceBetween(),
        ButtonComponents.buttonCircleIcon(
            icon: "assets/svg/settings.svg",
            size: isTabletHorizontal(context) ? 94.0 : 54.0,
            iconSize: isTabletHorizontal(context) ? 35.0 : 20.0,
            colorBg: ColorsApp.grey38Alpha,
            action: () {}),
        //zoom
        buttonsSpaceBetween(),
        ButtonComponents.buttonCircleIcon(
            icon: "assets/svg/zoom-plus.svg",
            size: isTabletHorizontal(context) ? 94.0 : 54.0,
            iconSize: isTabletHorizontal(context) ? 38.0 : 22.0,
            colorBg: ColorsApp.grey38Alpha,
            action: () async {
              // await controller.setZoom("menos");
              unityZoom('zoomIn');
            }),
        buttonsSpaceBetween(),
        ButtonComponents.buttonCircleIcon(
            icon: "assets/svg/zoom-m.svg",
            size: isTabletHorizontal(context) ? 94.0 : 54.0,
            iconSize: isTabletHorizontal(context) ? 38.0 : 22.0,
            colorBg: ColorsApp.grey38Alpha,
            action: () async {
              // await controller.setZoom("mais");
              unityZoom('zoomOut');
            }),
      ],
    );
  }

  Widget medidores() {
    String textVelocidade = '-.-  km/h';
    if (speed > 0) {
      textVelocidade = speed.toStringAsFixed(2) + ' km/h';
    }
    double satBluetooth = 12;
    double dopBluetooth = 0.8;
    return MetersWidget(
        textVelocidade: textVelocidade,
        areaPercoridaHa: areaPercoridaHa.toStringAsFixed(2),
        areaPercorida: areaPercorida.toStringAsFixed(2),
        sat: satBluetooth,
        dop: dopBluetooth);
  }

  buttonsSpaceBetween() {
    return SizedBox(height: 15);
  }

  Widget buttonsRight() {
    return ListView(
      //era um column
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: medidores(),
        ),
        Row(
          mainAxisAlignment: isTabletHorizontal(context)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: isTabletHorizontal(context) ? 5 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  played == true
                      ? ButtonComponents.buttonCircleIcon(
                          icon: "assets/svg/stop.svg",
                          colorBg: ColorsApp.orange,
                          size: isTabletHorizontal(context) ? 94.0 : 54.0,
                          iconSize: isTabletHorizontal(context) ? 35.0 : 20.0,
                          action: () {
                            stop();
                            // CustomDialog.customize(context,
                            //     content: DialogStoped(
                            //   onTap: () {
                            //     controller.setStoped(true, context);
                            //   },
                            // ));
                          })
                      : Container(),
                  SizedBox(height: played == true ? 15 : 0),
                  if (played == true) butB(),
                  if (played == true) buttonsSpaceBetween(),
                  if (played == true) butA(),
                  if (played == true) buttonsSpaceBetween(),
                  played == true
                      ? ButtonComponents.buttonCircleBorder(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'A/B',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsApp.grey90,
                                    fontSize:
                                        isTabletHorizontal(context) ? 18 : 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'AUTO',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsApp.grey90,
                                    fontSize:
                                        isTabletHorizontal(context) ? 18 : 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          size: isTabletHorizontal(context) ? 94.0 : 54.0,
                          sizeBorder: isTabletHorizontal(context) ? 10.0 : 5.0,
                          colorBg: ColorsApp.grey200,
                          colorBorder: ColorsApp.grey38Alpha,
                          action: () {
                            unitySetLineVisibility("y");
                          },
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(
              flex: isTabletHorizontal(context) ? 5 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  played == true
                      ? ButtonComponents.buttonCircleIcon(
                          icon: "assets/svg/pause.svg",
                          colorBg: ColorsApp.green30,
                          size: isTabletHorizontal(context) ? 94.0 : 54.0,
                          iconSize: isTabletHorizontal(context) ? 35.0 : 20.0,
                          action: () {
                            setState(() {
                              stop();
                            });
                            // positionStreamStarted = false;
                            // if (controller.gpsType == GpsType.bluetooth) {
                            //   geolocatorBluetooth();
                            // } else {
                            //   _toggleListening();
                            // }
                          },
                        )
                      : ButtonComponents.buttonCircleIcon(
                          icon: "assets/svg/play.svg",
                          size: isTabletHorizontal(context) ? 94.0 : 54.0,
                          iconSize: isTabletHorizontal(context) ? 35.0 : 20.0,
                          colorBg: ColorsApp.green30,
                          action: () {
                            //getConnection();

                            setState(() {
                              setPlayed();
                              // setPlayed(true);
                            });
                          },
                        ),
                  buttonsSpaceBetween(),
                  ButtonComponents.buttonCircleIcon(
                      icon: "assets/svg/merge.svg",
                      size: isTabletHorizontal(context) ? 94.0 : 54.0,
                      iconSize: isTabletHorizontal(context) ? 35.0 : 20.0,
                      colorBg: ColorsApp.grey38Alpha,
                      action: () {
                        // Modular.to.pushNamed(SCREEN_REGISTER_IMPLEMENT);
                      }),
                  buttonsSpaceBetween(),
                  ButtonComponents.buttonCircleIcon(
                      icon: "assets/svg/brush.svg",
                      size: isTabletHorizontal(context) ? 94.0 : 54.0,
                      iconSize: isTabletHorizontal(context) ? 35.0 : 20.0,
                      colorBg: ColorsApp.grey38Alpha,
                      action: () {
                        trailVisibility = trailVisibility == "y" ? "n" : "y";
                        unitySetTrailVisibility(trailVisibility);
                      }),
                  buttonsSpaceBetween(),
                  ButtonComponents.buttonCircleIcon(
                    icon: "assets/svg/help-sing.svg",
                    size: isTabletHorizontal(context) ? 94.0 : 54.0,
                    iconSize: isTabletHorizontal(context) ? 22.0 : 15.0,
                    colorBg: ColorsApp.grey38Alpha,
                    action: () {
                      // Modular.to.pushNamed(SCREEN_REGISTER_IMPLEMENT);
                    },
                  ),
                  buttonsSpaceBetween(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
