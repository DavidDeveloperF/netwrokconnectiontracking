// core / external packages
import 'package:flutter/material.dart';
// app
import 'package:networkconnectiontracking/network/network_class.dart';
import 'package:networkconnectiontracking/network/pollnetwork.dart';
import 'package:networkconnectiontracking/main_variables.dart';
import 'package:networkconnectiontracking/utils/utilities.dart';
import 'package:networkconnectiontracking/test_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Network Connections Tracker'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionValuesList = [];    // initialise connectionValuesList
    trackerSessionList = [];    // initialise connectionValuesList

    getVersionNumber();         // get app version/build
    futureCheckPlatform();      // get device info
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title +" - " + appVersion),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentDeviceDetails),
            Text(
              'You have pushed the + button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(                                                     // get network display
              child: Text("Test Menu"),
              color: Colors.blueAccent,
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyTestMenu())),
            ),

                RaisedButton(                                                     // get Sensor FUNCTION
                child: Text("Run Sensors function"),
              color: Colors.green,
              onPressed: () => getSensorInfo(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
