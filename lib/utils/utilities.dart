import 'dart:typed_data';
import 'dart:io';                                     // for Platform
import 'package:device_info/device_info.dart';        // for Platform & platformInfo
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';    // app version & build

import 'package:networkconnectiontracking/main_variables.dart';
import 'package:networkconnectiontracking/utils/mydebuglog_class.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~~~~~~~~~~~~     C O R E    U T I L I T I E S      ~~~~~~~~~~~~~~~~~~~~~
// # myDebugPrint   - Formats a debugPrint message (print, log or both)
// # getDateKey     - turns DateTime to long integer most recent=lowest number
// # translateDateKey takes myDateKey (String) and returns a dateTime
// # getVersionNumber - get build, version and package data                async
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


// #############################################################################
// # myDebugPrint
// #
// # Formats a debugPrint message, which then can be:
// #  - passed to std debugPrint routine
// #  = logged in a database
// #  or maybe just suppressed
// #############################################################################
myDebugPrint(String _message, String _whereFrom, bool _isCritical) {
  String nowFormatted = getShortDateStringFromDate(DateTime.now());
  String criticalWarning = "";
  bool suppressMessage = false;
  String _msgText;
  // todo: write code to suppress unneeded logs
  if (_isCritical) {criticalWarning = "<<CRITICAL>>";}

  if(!suppressMessage || _isCritical) {

    _msgText = criticalWarning + "//"+ nowFormatted + "/" + appName + "/" +
        appVersion+"_"+appBuildNumber + "/" +
        _whereFrom +"/ " +    _message;

    if (printDebugMessage) {
      debugPrint(_msgText);
    }
    if(logDebugMessage) {
      // todo: put some debug logging code here if Firebase db in use
      workingMyDebugLog = MyDebugLog(
        key: "xx",
        aLoggedText: _message,
        whereFrom: _whereFrom,
        createDate: getLongDateString(DateTime.now()),
        appVersion: appVersion + appBuildNumber,
        createUser: currentUser,
        createName: currentName,
        createDevice: currentDeviceId,
        createLat: currentLat,
        createLng: currentLng,
        region: currentRegion,
        isTestUser: false
      );
      debugPrint(criticalWarning + "//"+ nowFormatted + "/" + appName + "/" + appVersion+"_"+appBuildNumber + "/" +
          _whereFrom +"/ " +
          _message);
    }
  }
}

// ############################################################################# getDateKey
// #    getDateKey - turns DateTime to long integer most recent=lowest number
// #               - usually saved as a String as the item's key
// #############################################################################
int getDateKey(DateTime inputDate) {
  int myDateKey;

  if (inputDate != null) {
    myDateKey = longFutureDate - inputDate.millisecondsSinceEpoch;
  } else {
    myDateKey = longFutureDate - DateTime.now().millisecondsSinceEpoch;
  }
  return myDateKey;
} // end of getDateKey

// ############################################################################# translateDateKey
// # translateDateKey
// #
// # translateDateKey takes myDateKey (String) and returns a dateTime
// #
// # 0.30c key is a String !, so take parameter as string and convert it here.
// #       if for any reason I have an int key, I can cast it .toString()
// #############################################################################
DateTime translateDateKey(String myDateKey) {
  DateTime keyDateTime;

  if (myDateKey != null) {
    keyDateTime =
        DateTime.fromMillisecondsSinceEpoch(longFutureDate - int.parse(myDateKey));
    return keyDateTime;
  } else {
    return DateTime.now();
  }
} // end of translateDateKey

// ############################################################################# getVersionNumber
// #  getVersionNumber - get build, version and package data
// #############################################################################
void getVersionNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appName = packageInfo.appName;
  appVersion = packageInfo.version;
  appBuildNumber = packageInfo.buildNumber;
  appPackageName = packageInfo.packageName;
  myDebugPrint(" App Name: " + appName +
      " Version: "  + appVersion +
      " Build: "    + appBuildNumber
      ,  "getVersionNumber", false);
}

// ############################################################################# futureCheckPlatform
//   futureCheckPlatform
//   - load the platform info (to get Device id)
//   - calls _checkPlatform (below)
// #############################################################################
void futureCheckPlatform() {
  String whereAmI = "futureCheckPlatform";
  var then = _checkPlatform().then((value) => {
  }); // end of .then
} //                                                                      end of futureCheckPlatform

Future<String> _checkPlatform() async {
  String whereAmI = "_checkPlatform";

  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    var id = androidInfo.androidId;
    currentDeviceId = id;
    currentDeviceDetails = 'Android $release (SDK $sdkInt), $manufacturer $model';
    myDebugPrint(currentDeviceDetails + " / " + currentDeviceId
        ,whereAmI+"Android", false);
    return 'Android $release (SDK $sdkInt), $manufacturer $model, device id: $id';
    // Android 9 (SDK 28), Xiaomi Redmi Note 7
  }
  if (Platform.isIOS) {
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    var systemName = iosInfo.systemName;
    var version = iosInfo.systemVersion;
    var name = iosInfo.name;
    var model = iosInfo.model;
    var id = iosInfo.utsname
        .toString(); // unsure what's iOS equivalent of device id
    currentDeviceId = id;
    currentDeviceDetails = 'iOS $systemName $version, $name $model ';
    myDebugPrint(currentDeviceDetails + " / " + currentDeviceId
        ,whereAmI+"iOS", false);
    // debugPrint(
    //     '** $_localModule $systemName $version, $name $model, device id: $id');
    // iOS 13.1, iPhone 11 Pro Max iPhone
  }
}