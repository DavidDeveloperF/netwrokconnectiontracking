import 'package:android_device_info/android_device_info.dart';
import 'package:flutter/material.dart';
import 'package:networkconnectiontracking/network/polllocation.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:location/location.dart';
// local
import 'package:networkconnectiontracking/main_variables.dart';
import 'package:networkconnectiontracking/utils/utilities.dart';
import 'network_class.dart';

// ############################################################################  getNetworkFunction
// #
// # getNetworkFunction
// #
// #  + check there is a Session or create one
// #  + run the getAllData function
// #############################################################################
void getNetworkFunction() {
  checkSessionAndConnection(); // set up session (if don't have one)
  getAllData(
    true, // display
    true, // battery
    true, // memory
    true, // network
    true, // NFC
    true, // Location
    true, // SIM
  ); // getData is the async function to load the device info
}

// ############################################################################# checkSessionAndConnection()
// # checkSessionAndConnection
// #
// # Make sure we have a session
// # if not, empty the session list and start a new session
// #############################################################################
void checkSessionAndConnection() {
  // Temporary setup code                                                         newSession required
  // make sure we have a Session, index and it's in the list
  if (workingTrackerSessionIndex == null || trackerSessionList.isEmpty) {
    workingTrackerSessionIndex = 0;
    setUpNewSession();
  }

  // should never get here.................
  if (workingConnectionValuesIndex == null) {
    workingConnectionValuesIndex = 0;
    workingConnectionValues = defaultConnectionValues;
  }
} //      end of setUpSessionAndConnection

// ############################################################################# setUpNewSession
// #############################################################################
void setUpNewSession() {
// todo: should set up a proper 'new' session function
// set defaults
  workingTrackerSession = defaultTrackerSession;
// update key, dates, etc
  workingTrackerSession.key = getDateKey(DateTime.now());
  workingTrackerSession.dateTimeInt = DateTime.now().millisecondsSinceEpoch;
  workingTrackerSession.dateTimeText = getLongDateString(DateTime.now());
  // todo:  add in the other variables like user, etc
  // add to list
  trackerSessionList.add(workingTrackerSession);

  // if this is a new session, then clear the connection list
  connectionValuesList = [];
  workingConnectionValuesIndex = 0;
  workingConnectionValues = defaultConnectionValues;
  workingConnectionValuesChanged = false;
}

// ############################################################################
// # getAllData
// # goes through selected info APIs and saves the result in data
// #
// # Expects to have a Session as parent
// #
// ############################################################################
getAllData(bool getDisplay, bool getBattery, bool getMemory, bool getNetwork,
    bool getNFC, bool getLocation, bool getSIM) async {
  bool showDebugDetails = true;                                    //  use this to show/suppress kogging
  String _locationText;
  String whereAmI = "getAllData";
  String whereAmIDetail;
  var data = {}; // data is a generic variable

  workingConnectionValuesChanged = false;

  // # final XXXXXX = await AndroidDeviceInfo().getXXXXX();               todo: find out why is this 'final'
  // #       appears to return a Map with all the values for Key + Value
  // # Eg:   Future<Map<dynamic, dynamic>> getMemoryInfo({String unit = "bytes"}) async {
  // #
  // # so I can XXXXXX.ForEach to loop through them

  // if xx try
  //    xx = await AndroidDeviceInfo().getXX
  //         if showDebugDetails
  //            loop thorugh resutls & print
  //    add xx to data
  // catch errors
// ??????????????? Why was this code put AFTER the getSinInfo ? Surely it should be run BEFORE ??
// Part of the original code...............
// this appears to be checking whether user has given access to permission        PHONE permissions ?
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
  var permissionLoc = await PermissionHandler()
      .checkPermissionStatus(PermissionGroup.locationAlways);
  if (permissionLoc == PermissionStatus.denied) {
    //                                        if no permission, turn off getLocation
    getLocation = false;
    currentLocationText = defaultConnectionValues.locationText;
    currentLat          = defaultConnectionValues.lat;
    currentLng          = defaultConnectionValues.lng;
    //                                        if no permission, request permission
    var permissionsLoc = await PermissionHandler()
        .requestPermissions([PermissionGroup.locationAlways]);
    if (permissionsLoc[PermissionGroup.locationAlways] ==
        PermissionStatus.granted) {
      // var location = await AndroidDeviceInfo().getLocationInfo();
      // data.addAll(location);
      getLocation = true;               //    turn it back on again if permission granted
    } // end of GRANTED
  } // end of DENIED

  if (getLocation) {
    try {
      // TODO this does not seem to be working???
      whereAmIDetail = whereAmI + " location";
      refreshLocation();                                                  // alt code taken from WATD
    } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }
  } // end of getLocation



  if (getDisplay) {
    try {
      whereAmIDetail = whereAmI + " display";
      final display =
          await AndroidDeviceInfo().getDisplayInfo(); // display data
      if (showDebugDetails) {
        // don't always want debug detail
        display.forEach((key, value) {
          myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
        });
      }
      data.addAll(display);
    } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }
  } // end of getDisplay

  if (getBattery) {
    try {
      whereAmIDetail = whereAmI + " battery";
      final battery =
          await AndroidDeviceInfo().getBatteryInfo(); // battery data
      if (showDebugDetails) {
        // don't always want debug detail
        battery.forEach((key, value) {
          myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
        });
      }
      data.addAll(battery);
    } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }
  } // end of getBattery



  if (getMemory) {
    try {
      whereAmIDetail = whereAmI + " memory";
      final memory = await AndroidDeviceInfo().getMemoryInfo(); // memory data
      if (showDebugDetails) {
        // don't always want debug detail
        memory.forEach((key, value) {
          myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
        });
      }
      data.addAll(memory);
    } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }
  } // end of getMemory

  if (getNetwork) {
    try {
      whereAmIDetail = whereAmI + " network";
      final network =
          await AndroidDeviceInfo().getNetworkInfo(); // Network data
      if (showDebugDetails) {
        // don't always want debug detail
        network.forEach((key, value) {
          myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
        });
      }
      data.addAll(network);
    } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }
  } // end of getNetwork

  if (getNFC) {
    try {
      whereAmIDetail = whereAmI + " nfc";
      final nfc = await AndroidDeviceInfo().getNfcInfo(); // NFC data
      if (showDebugDetails) {
        // don't always want debug detail
        nfc.forEach((key, value) {
          myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
        });
      }
      data.addAll(nfc);
    } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }
  } // end of getNFC

  // maybe working - not sure
  // todo: follow up obscure errors depending on the device / android version
  if (getSIM) {
    try {
      whereAmIDetail = whereAmI + " sim";
      var sim = await AndroidDeviceInfo().getSimInfo(); // SIM data
      sim.forEach((key, value) {
        myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
      });
      data.addAll(sim);
    } catch (e) {
      myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
    }
  } // end of getSIM



  // in case any of the preceding data are missing, load default values first
  workingConnectionValues = defaultConnectionValues;

  // if (currentLat == 0.0) {
  //   _locationText = "no location data";
  // } else {
  //   String _locationText = "Location is lat: " +currentLat.toStringAsFixed(4) +
  //                                     " lng:"  +currentLng.toStringAsFixed(4);
  // }

  workingConnectionValues = ConnectionValues(
    key:              getDateKey(DateTime.now()).toString(),
    parentKey:        workingTrackerSession.key,
    sequenceNo:       workingConnectionValuesIndex,
    dateTimeInt:      DateTime.now().millisecondsSinceEpoch,
    dateTimeText:     getLongDateString(DateTime.now()),
    lat:              currentLat,
    lng:              currentLng,
    locationText:     currentLocationText,
    isNetworkAvailable: data['isNetworkAvailable'],
    networkType:      data['networkType'],
    isWifiEnabled:    data['isWifiEnabled'],
    wifiLinkSpeed:    data['wifiLinkSpeed'],
    wifiSSID:         data['wifiSSID'],
    carrier:          data['carrier'],
    downloadSpeed:    data['downloadSpeed'],       // can't get speed from above
    uploadSpeed:      data['uploadSpeed'],         // can't get speed from above
    speedUnits:       "Mbps",
  );


  debugPrint("about to test workingConnectionValuesIndex for null");
  if (workingConnectionValuesIndex != null) {
    debugPrint("INSIDE connectionValuesList.add");
    connectionValuesList.add(workingConnectionValues);
    workingConnectionValuesIndex = workingConnectionValuesIndex + 1;
  }

  myDebugPrint(
      "workingConnectionValues = " +
          workingConnectionValues.key +
          " / ParentKey: " +
          workingTrackerSession.key +
          " / " +
          workingConnectionValues.sequenceNo.toString() +
          " / " +
          workingConnectionValues.dateTimeText +
          " / " +
          " Date key is: " +
          getLongDateString(translateDateKey(workingConnectionValues.key)),
      whereAmI,
      false);
} // end of getData  ########################################################## // end of getData


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
    final sensorInfo = await AndroidDeviceInfo().getSensorInfo(); // Sensor data
    int _counter = 0;
    sensorInfo.forEach((element) {
      // myDebugPrint("sensorInfo Counter: $_counter  Element: " + element.toString()
      //     ,  whereAmI, false);
      workingSensorInfo = SensorInfo(
        name: element['name'],
        vendor: element['vendor'],
        version: element['version'],
        power: element['power'],
        maximumRange: element['maximumRange'],
        resolution: element['resolution'],
      );
      myDebugPrint(
          "sensor present: " + workingSensorInfo.name, whereAmI, false);

      _counter = _counter + 1;
    });
  } catch (e) {
    myDebugPrint("## ERROR ## The exception thrown is $e", whereAmI, true);
  }
}
