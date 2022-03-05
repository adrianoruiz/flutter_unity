import 'package:flutter/material.dart';
import 'package:tut/secondPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DagaAgro',

      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: UnityTestingWrapper()
      home: MyHomePage(title: 'DagaAgro Mapa Homolog'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem vindo!',
            ),
            MaterialButton(
              child: Text("Ir para o mapa"),
              minWidth: double.infinity,
              onPressed: () async {
                Navigator.of(context).push((MaterialPageRoute(
                    builder: (BuildContext context) => UnityTestingWrapper())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
