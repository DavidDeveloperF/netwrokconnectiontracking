// Start a session to record network results at each location
//import 'package:flutter/cupertino.dart';

class TrackerSession {
  String     key;                             // session key
  String     dateTimeText;                    // string for display purposes
  int        dateTimeInt;                     // actual date (int sec from epoch)
  String     locationText;                    // description of where started
  String     deviceId;                        // device  id
  String     deviceDescription;               // model/OS/ etc
  String     userId;                          // user
  String     appName;                         // in case I have multiple apps sharing the db
  String     appVersion;                      // what version of the app
  String     imsi;                            // SIM imsi
  String     serial;                          // SIM serial
  String     country;                         // SIM country
  String     carrier;                         // SIM carrier-NetworkProvider
  double     batteryPercent;                  // how much battery on start
  int        refreshRate;                     // refresh every nnn seconds
  String     aComment;                        // might be useful
  String     spareString;                     // might be useful
  int        spareInt;                        // might be useful
  TrackerSession ({
    this.key,
    this.dateTimeText,
    this.dateTimeInt,
    this.locationText,
    this.deviceId,
    this.deviceDescription,
    this.userId,
    this.appName,
    this.appVersion,
    this.imsi,
    this.serial,
    this.country,
    this.carrier,
    this.batteryPercent,
    this.refreshRate,
    this.aComment,
    this.spareString,
    this.spareInt,

  });
}

List<TrackerSession>  trackerSessionList;                       // array to store TrackerSession values
TrackerSession        workingTrackerSession;                       // a working or current TrackerSession set
int                   workingTrackerSessionIndex;                                   // integer index of current place in the array
bool                  workingTrackerSessionChanged;                           // bool to flag whether working___ has been changed
TrackerSession defaultTrackerSession = TrackerSession  (
  key:              "123456789000",
  dateTimeText:     "1",
  dateTimeInt:      123456677,
  locationText:     "Thu 21-June 18:30",
  deviceId:         "xvxvxvxvxv",
  deviceDescription: "Nexus 5X",
  userId:           "userId",
  appName:          "app name",
  appVersion:       "app version",
  imsi:             "gfdsgsfd",
  serial:           "1212121212",
  country:          "UK",
  carrier:          "EE",
  batteryPercent:   98.5,
  refreshRate:      300,
  aComment:         "blank",
  spareString:      "blank",
  spareInt:         1234,

);



// #############################################################################
// Every [refreshRate] seconds, take another reading
class ConnectionValues {
  String     key;                             // value Key - date/time key
  String     parentKey;                       // in this case, TrackerSession.key
  int        sequenceNo;                      // number of tests this session
  int        dateTimeInt;                     // date time as integer
  String     dateTimeText;                    // date time as string
  double     lat;                             // lattitude
  double     lng;                             // longitude
  String     locationText;                    // where is it (maybe)
  bool       isNetworkAvailable;              // might not have a connection
  String     networkType;                     // networkType
  bool       isWifiEnabled;                   // isWifiEnabled
  String     wifiLinkSpeed;                   // wifiLinkSpeed
  String     wifiSSID;                        // wifiSSID
  String     carrier;                         // carrier - in case it changes during tracking
  double     downloadSpeed;                   // downloadSpeed
  double     uploadSpeed;                     // uploadSpeed
  String     speedUnits;                      // Mbps or kbps

  ConnectionValues ({
      this.key,
      this.parentKey,
      this.sequenceNo,
      this.dateTimeInt,
      this.dateTimeText,
      this.lat,
      this.lng,
      this.locationText,
      this.isNetworkAvailable,
      this.networkType,
      this.isWifiEnabled,
      this.wifiLinkSpeed,
      this.wifiSSID,
      this.carrier,
      this.downloadSpeed,
      this.uploadSpeed,
      this.speedUnits,
  });
}   // End of ConnectionValues

List<ConnectionValues> connectionValuesList;            // array to store ConnectionValues values
ConnectionValues      workingConnectionValues;          // a working or current ConnectionValues set
int                   workingConnectionValuesIndex =0;  // index of current place in the array
bool                  workingConnectionValuesChanged;   // has working been changed

ConnectionValues defaultConnectionValues = ConnectionValues  (
  key:            "123456789000",
  parentKey:      "123456789000",
  sequenceNo:     1,
  dateTimeInt:    123456677,
  dateTimeText:    "Thu 21-June 18:30",
  lat:             0.28,
  lng:            -0.45003,
  locationText:   "Default location",
  isNetworkAvailable:   false,
  networkType:    "default network type",
  isWifiEnabled:   false,
  wifiLinkSpeed:  "deafult 1Mbps",
  wifiSSID:       "default SSID",
  carrier:        "default carrier",
  downloadSpeed:   3.14159,
  uploadSpeed:     3.14159,
  speedUnits:     "Mbps",

);


class SensorInfo {
  String     vendor;                          // who made the sensor
  String     name;                            // What is the sensor
  double     maximumRange;                    // what is the value range
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
