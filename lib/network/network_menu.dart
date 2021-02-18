// external
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_device_info/android_device_info.dart';
// app code
import 'package:networkconnectiontracking/utils/utilities.dart';



//  Seems like this widget returns a scrollable column
class NetworkTab extends StatefulWidget {
  @override
  _NetworkTabState createState() => _NetworkTabState();
}

class _NetworkTabState extends State<NetworkTab> {
  var data = {};

  @override
  void initState() {
    super.initState();

    getAllData(
                true,     // display
                true,     // battery
                true,     // memory
                true,     // network
                true,     // NFC
                true,     // Location
                true,     // SIM
    );              // getData is the async function to load the device info
  }


  @override
  Widget build(BuildContext context) {
    //                                                                    if no data, return Circle
    if (data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    //                                                                    (implied) else, we HAVE data
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(),
          RowItem('Network Available', '${data['isNetworkAvailable']}'),
          RowItem('Network', '${data['networkType']}'),
          RowItem('iPv4 Address', '${data['iPv4Address']}'),
          RowItem('iPv6 Address', '${data['iPv6Address']}'),
          RowItem('WiFi Enabled', '${data['isWifiEnabled']}'),
          RowItem('WiFi SSID', '${data['wifiSSID']}'),
          RowItem('WiFi BSSID', '${data['wifiBSSID']}'),
          RowItem('WiFi Speed', '${data['wifiLinkSpeed']}'),
          RowItem('Signal strength(Cellular)', '???'),
          RowItem('WiFi MAC', '${data['wifiMAC']}'),
          Divider(),
          RowItem('NFC Present', '${data['isNfcPresent']}'),
          RowItem('NFC Enabled', '${data['isNfcEnabled']}'),
          Divider(),
          RowItem('IMSI', '${data['imsi']}'),
          RowItem('Serial', '${data['serial']}'),
          RowItem('Country', '${data['country']}'),
          RowItem('Carrier', '${data['carrier']}'),
          RowItem('SIM Locked', '${data['isSimNetworkLocked']}'),
          RowItem('activeMultiSimInfo', '${data['activeMultiSimInfo']}'),
          RowItem('Multi SIM', '${data['isMultiSim']}'),
          RowItem('Active SIM(s)', '${data['numberOfActiveSim']}'),
          Divider(),
        ],
      ),
    );
  }
}


// ###########################################################################   RowItem
// # this was not part of the source code
// # I have guessed what it should be - a row with the title & result/value
// ###########################################################################
Widget RowItem(String colTitle, String resultString) {
//  String x;
//  int _lengthTitle = colTitle.length;
  int _columnWidth = 45;

  return Row(children: <Widget>[
    Text(colTitle.padRight(_columnWidth)),
    Text(": "),
    Text(resultString),
  ]);
}

// ############################################################################
// # getAllData
// # goes through the main info APIs and saves the result in data
// ############################################################################
getAllData(bool getDisplay, bool getBattery, bool getMemory, bool getNetwork,
           bool getNFC,     bool getLocation, bool getSIM ) async {
  String whereAmI = "getAllData";
  String whereAmIDetail;
  var data = {};                                  // data is a generic variable

  // # final XXXXXX = await AndoridDeviceInfo().getXXXXX();
  // #       appears to return a Map with all the values for Key + Value
  // # Eg:   Future<Map<dynamic, dynamic>> getMemoryInfo({String unit = "bytes"}) async {
  // #
  // # so I can XXXXXX.ForEach to loop through them

  if(getDisplay){  try {
      whereAmIDetail = whereAmI + " display";
      final display = await AndroidDeviceInfo().getDisplayInfo();                // display data
      display.forEach((key, value) {
        myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
      });
      data.addAll(display);
    } catch (e) {
        myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }}                                                                          // end of getDisplay

  if(getBattery) {try {
    whereAmIDetail = whereAmI + " battery";
    final battery = await AndroidDeviceInfo().getBatteryInfo();                // battery data
    battery.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });
    data.addAll(battery);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                                                                          // end of getBattery

  if(getMemory) {try {
    whereAmIDetail = whereAmI + " memory";
    final memory = await AndroidDeviceInfo().getMemoryInfo();                 // memory data
    memory.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });
    data.addAll(memory);
  } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                                                                          // end of getMemory

  if(getNetwork) {try {
    whereAmIDetail = whereAmI + " network";
    final network = await AndroidDeviceInfo().getNetworkInfo();                // Network data
    network.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });
    data.addAll(network);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                                                                          // end of getNetwork

  if(getNFC) {try {
    whereAmIDetail = whereAmI + " nfc";
    final nfc = await AndroidDeviceInfo().getNfcInfo();                        // NFC data
    nfc.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });
    data.addAll(nfc);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }} // end of getNFC

  if(getLocation) {try {
    whereAmIDetail = whereAmI + " location";
    final location = await AndroidDeviceInfo().getLocationInfo();                // location data
    location.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });
    data.addAll(location);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}  // end of getLocation

  // maybe working - not sure
  // todo: follow up obscure errors dependingont eh device / android version
  if (getSIM) {try {
    whereAmIDetail = whereAmI + " sim";
    var sim = await AndroidDeviceInfo().getSimInfo();                         // SIM data
    sim.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });
    data.addAll(sim);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                              // end of getSIM


  // Part of the original code...............
  // this appears to be checking whether user has given access to permission     PHONE
  var permission =
  await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
  if (permission == PermissionStatus.denied) {
    //                                         if no permission, request permission
    var permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.phone]);
    if (permissions[PermissionGroup.phone] == PermissionStatus.granted) {
      var sim = await AndroidDeviceInfo().getSimInfo();
      data.addAll(sim);
    } // end of GRANTED
  } // end of DENIED

  // my clone of the above
  // this appears to be checking whether user has given access to permission     LOCATION (always)
  var permissionLoc =
  await PermissionHandler().checkPermissionStatus(PermissionGroup.locationAlways);
  if (permissionLoc == PermissionStatus.denied) {
    //                                         if no permission, request permission
    var permissionsLoc =
    await PermissionHandler().requestPermissions([PermissionGroup.locationAlways]);
    if (permissionsLoc[PermissionGroup.locationAlways] == PermissionStatus.granted) {
      var location = await AndroidDeviceInfo().getLocationInfo();
      data.addAll(location);
    }     // end of GRANTED
  }     // end of DENIED

}   // end of getData

class SensorInfo {
  String     vendor;                          // who made the sensor
  String     name;                            // What is the sensor
  double     maximumRange;                    // what is the raneg of values
  double     power;                           // not sure what it means by 'Power'
  int        version;                         //  version of sensor
  double     resolution;                      // smallest change in value (probably)
  SensorInfo ({
    this.vendor,
    this.name,
    this.maximumRange,
    this.power,
    this.version,
    this.resolution,
  });
}

SensorInfo  workingSensorInfo;                       // a working or current SensorInfo set
// List<SensorInfo> sensorInfoList;                       // array to store SensorInfo values
//int     workingSensorInfoIndex;                                   // integer index of current place in the array
//bool workingSensorInfoChanged;                           // bool to flag whether working___ has been changed



// ############################################################################# getSensorInfo
// # gets sensor info - this is a different format from the other device info
// #
// # todo:  probably need to establish common variables to share the result data
// #############################################################################
void getSensorInfo() async {
// # sensorInfo does not behave the same as the others ?????
// # Eg   Future<List<dynamic>> getSensorInfo() async {
// #      It returns s List not a map ??
// #  Why does it do this?
// #  .. I can see why - there's a complicated data structure - see below examples
// I/flutter (15345): sensorInfo Counter: 9  Element: {vendor: The Android Open Source Project, name: Goldfish 3-axis Magnetic field sensor (uncalibrated), maximumRange: 2000.0, power: 6.699999809265137, version: 1, resolution: 0.5}
// I/flutter (15345): sensorInfo Counter: 10  Element: {vendor: AOSP, name: Game Rotation Vector Sensor, maximumRange: 1.0, power: 12.699999809265137, version: 3, resolution: 5.960464477539063e-8}

  String whereAmI = "getSensorInfo";

  try {
    final sensorInfo = await AndroidDeviceInfo().getSensorInfo();                // Sensor data
    int _counter = 0;
    sensorInfo.forEach((element) {
      // myDebugPrint("sensorInfo Counter: $_counter  Element: " + element.toString()
      //     ,  whereAmI, false);
      workingSensorInfo = SensorInfo(
        name:         element['name'],
        vendor:       element['vendor'],
        version:      element['version'],
        power:        element['power'],
        maximumRange: element['maximumRange'],
        resolution:   element['resolution'],
      );
     myDebugPrint("sensor present: " + workingSensorInfo.name
         ,  whereAmI, false);

      _counter = _counter +1;
    });
  } catch (e) {
    myDebugPrint("## ERROR ## The exception thrown is $e", whereAmI, true);
  }
}