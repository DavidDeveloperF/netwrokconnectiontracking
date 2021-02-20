import 'package:flutter/material.dart';
import 'package:networkconnectiontracking/main_variables.dart';

import 'network/network_class.dart';
import 'network/network_menu.dart';
import 'network/pollnetwork.dart';
import 'network/speedtest_menu.dart';

class MyTestMenu extends StatefulWidget {
  @override
  _MyTestMenuState createState() => _MyTestMenuState();
}

class _MyTestMenuState extends State<MyTestMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Menu / "+ appName),),
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Refreshed: " + getLongDateString(DateTime.now())
          ),
           Divider(),
           RaisedButton(                                                     // get network display
            child: Text("Run network widget"),
            color: Colors.blueAccent,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DisplayNetworkStuff())),
          ),
          RaisedButton(                                                     // download speed
            child: Text("Download speed (background)"),
            color: Colors.red,
            onPressed: (){
              backgroundDownload();
            },
          ),
          RaisedButton(                                                     // upload speed
            child: Text("Upload speed (background)"),
            color: Colors.red,
            onPressed: (){
              backgroundUpload();
            },
          ),
          RaisedButton(                                                     // get network display
            child: Text("Run speed test"),
            color: Colors.blueAccent,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MySpeedTestMenu())),
          ),
          RaisedButton(                                                     // get network FUNCTION
            child: Text("Run network function"),
            color: Colors.green,
            onPressed: () async {
              debugPrint("ABOUT TO RUN getNetworkFunction ~~~~~~~~~~~~~~~~~~~~~~~");
              getNetworkFunction();
              debugPrint("after RUNNING getNetworkFunction ~~~~~~~~~~~~~~~~~~~~~~~");
              if (workingConnectionValues != null) {
                debugPrint("INSIDE  workingConnectionValues != NULL ~~~~~~~~~~~~~~~");
                connectionValuesList.add(workingConnectionValues);
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => MyNetworkConnectionDetail()));
              }
            },
          ),
          RaisedButton(                                                     // get network FUNCTION
            child: Text("Run network menu"),
            color: Colors.yellowAccent,
            onPressed: () async {
              if (workingConnectionValues != null) {
                debugPrint("INSIDE  workingConnectionValues != NULL ~~~~~~~~~~~~~~~");
                connectionValuesList.add(workingConnectionValues);
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => MyNetworkConnectionDetail()));
              } //end of IF
            }, // end of onPressed
          ),
          RaisedButton(                                                     // get Sensor FUNCTION
            child: Text("Run Sensors function"),
            color: Colors.green,
            onPressed: () => getSensorInfo(),
          ),
        ],
      ),
    ),
      )
    );
  }
}

// ############################################################################ DisplayNetworkStuff
class DisplayNetworkStuff extends StatefulWidget {
  @override
  _DisplayNetworkStuffState createState() => _DisplayNetworkStuffState();
}

class _DisplayNetworkStuffState extends State<DisplayNetworkStuff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Network info" + getShortDateStringFromDate(DateTime.now())),),
      body:   NetworkTab(),
    );
  }
}
