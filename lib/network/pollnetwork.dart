import 'package:android_device_info/android_device_info.dart';
import 'package:networkconnectiontracking/main_variables.dart';
import 'package:networkconnectiontracking/utils/utilities.dart';
import 'package:permission_handler/permission_handler.dart';

import 'network_class.dart';
import 'network_menu.dart';

//  Seems like this widget returns a scrollable column
void getNetworkFunction(){
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

// ############################################################################
// # getAllData
// # goes through the main info APIs and saves the result in data
// ############################################################################
getAllData(bool getDisplay, bool getBattery, bool getMemory, bool getNetwork,
    bool getNFC,     bool getLocation, bool getSIM ) async {

  bool showDebugDetails     = false;
  String whereAmI = "getAllData";
  String whereAmIDetail;
  var data = {};                                  // data is a generic variable

  workingConnectionValuesChanged = false;         // just setup a value
  if (workingConnectionValuesIndex == null) {
    workingConnectionValuesIndex =0;
    if (workingTrackerSessionIndex == null) {
      workingTrackerSessionIndex =0;
      workingTrackerSession = defaultTrackerSession;}}

  // # final XXXXXX = await AndoridDeviceInfo().getXXXXX();               todo: why is this 'final'
  // #       appears to return a Map with all the values for Key + Value
  // # Eg:   Future<Map<dynamic, dynamic>> getMemoryInfo({String unit = "bytes"}) async {
  // #
  // # so I can XXXXXX.ForEach to loop through them

  if(getDisplay){  try {
    whereAmIDetail = whereAmI + " display";
    final display = await AndroidDeviceInfo().getDisplayInfo();                // display data
    if (showDebugDetails){                                                    // don't always want debug detail
    display.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });}
    data.addAll(display);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                                                                          // end of getDisplay

  if(getBattery) {try {
    whereAmIDetail = whereAmI + " battery";
    final battery = await AndroidDeviceInfo().getBatteryInfo();                // battery data
    if (showDebugDetails){                                                    // don't always want debug detail
    battery.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });}
    data.addAll(battery);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                                                                          // end of getBattery

  if(getMemory) {try {
    whereAmIDetail = whereAmI + " memory";
    final memory = await AndroidDeviceInfo().getMemoryInfo();                 // memory data
    if (showDebugDetails){                                                    // don't always want debug detail
      memory.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });}
    data.addAll(memory);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                                                                          // end of getMemory

  if(getNetwork) {try {
    whereAmIDetail = whereAmI + " network";
    final network = await AndroidDeviceInfo().getNetworkInfo();                // Network data
    if (showDebugDetails){                                                    // don't always want debug detail
      network.forEach((key, value) {
      myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
    });}
    data.addAll(network);
  } catch (e) {
    myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
  }}                                                                          // end of getNetwork

  if(getNFC) {try {
    whereAmIDetail = whereAmI + " nfc";
    final nfc = await AndroidDeviceInfo().getNfcInfo();                        // NFC data
    if (showDebugDetails){                                                    // don't always want debug detail
        nfc.forEach((key, value) {
        myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
      });}
    data.addAll(nfc);
      } catch (e) {
        myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
      }} // end of getNFC

  if(getLocation) {try {                            // TODO this does not seem to be working???
    whereAmIDetail = whereAmI + " location";
    final location = await AndroidDeviceInfo().getLocationInfo();                // location data
    if (showDebugDetails){                                                    // don't always want debug detail
      location.forEach((key, value) {
        myDebugPrint(key + ": " + value.toString(), whereAmIDetail, false);
      });}
    data.addAll(location);
      } catch (e) {
          myDebugPrint("The exception thrown is $e", whereAmIDetail, true);
      }}  // end of getLocation

  // maybe working - not sure
  // todo: follow up obscure errors depending on the device / android version
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


  // in case any of the preceding data are missing, load default values first
  workingConnectionValues = defaultConnectionValues;

  workingConnectionValues = ConnectionValues  (
    key:                getDateKey(DateTime.now()).toString(),
    sequenceNo:         workingConnectionValuesIndex,
    dateTimeInt:        DateTime.now().millisecondsSinceEpoch,
    dateTimeText:       getLongDateString(DateTime.now()),
    lat:                currentLat,
    lng:                currentLng,
    locationText:       currentLocationText,
    isNetworkAvailable: data['isNetworkAvailable'],
    networkType:        data['networkType'],
    isWifiEnabled:      data['isWifiEnabled'],
    wifiLinkSpeed:      data['wifiLinkSpeed'],
    wifiSSID:           data['wifiSSID'],
    carrier:            data['carrier'],
    downloadSpeed:      data['downloadSpeed'],
    uploadSpeed:        data['uploadSpeed'],
    speedUnits:         "Mbps",
  );

  if (workingConnectionValuesIndex != null) {
    connectionValuesList.add(workingConnectionValues);
    workingConnectionValuesIndex = workingConnectionValuesIndex+1;
  }

  myDebugPrint("workingConnectionValues = " +
      workingConnectionValues.key + " / " +
      workingConnectionValues.sequenceNo.toString() + " / " +
      workingConnectionValues.dateTimeText + " / " +
      " Date key is: "+ getLongDateString(translateDateKey(workingConnectionValues.key))
      , whereAmI, false );

}   // end of getData



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
