// Start a session to record network results at each location
//import 'package:flutter/cupertino.dart';

class TrackerSession {
  String     key;                             // session key
  String     dateTimeText;                    // string for display purposes
  int        dateTimeInt;                     // actual date (int sec from epoch)
  String     locationText;                    // description of where started
  String     deviceId;                        // device
  String     userId;                          // user
  int        refreshRate;                     // refresh every nnn seconds
  String     comments;                        // might be useful
  String     spareString;                     // might be useful
  int        spareInt;                        // might be useful

    TrackerSession ({
    this.key,
    this.dateTimeText,
    this.dateTimeInt,
    this.locationText,
    this.deviceId,
    this.userId,
    this.refreshRate,
    this.comments,
    this.spareString,
    this.spareInt,
    });
} // end of TrackerSession

List<TrackerSession> trackerSessionList;                       // array to store TrackerSession values
TrackerSession  workingTrackerSession;                       // a working or current TrackerSession set
int     workingTrackerSessionIndex;                                                  // index of current plac ein the array
bool workingTrackerSessionChanged;


// #############################################################################
// Every [refreshRate] seconds, take another reading
// #############################################################################
class ConnectionValues {
  String     key;                             // value Key - date/time key
  int        sequenceNo;                      // number of tests this session
  int        dateTimeInt;                     // date time as integer
  String     dateTimeText;                    // date tm as string
  double     lat;                             // lattitude
  double     lng;                             // longitude
  String     locationText;                    // where is it
  bool       isNetworkAvailable;              // isNetworkAvailable
  String     networkType;                     // networkType
  String     iPv4Address;                     // iPv4Address
  String     iPv6Address;                     // iPv6Address
  bool       isWifiEnabled;                   // isWifiEnabled
  String     wifiSSID;                        // wifiSSID
  String     wifiBSSID;                       // wifiBSSID
  String     wifiLinkSpeed;                   // wifiLinkSpeed

  String     wifiMAC;                         // wifiMAC

  bool       isNfcPresent;                    // isNfcPresent
  bool       isNfcEnabled;                    // isNfcEnabled

  String     imsi;                            // imsi
  String     serial;                          // serial
  String     country;                         // country
  String     carrier;                         // carrier
  bool       isSimNetworkLocked;              // isSimNetworkLocked
  String     activeMultiSimInfo;              // activeMultiSimInfo
  bool       isMultiSim;                      // isMultiSim
  String     numberOfActiveSim;               // numberOfActiveSim

  ConnectionValues ({
    this.key,
    this.sequenceNo,
    this.dateTimeInt,
    this.dateTimeText,
    this.lat,
    this.lng,
    this.locationText,
    this.isNetworkAvailable,
    this.networkType,
    this.iPv4Address,
    this.iPv6Address,
    this.isWifiEnabled,
    this.wifiSSID,
    this.wifiBSSID,
    this.wifiLinkSpeed,

    this.wifiMAC,

    this.isNfcPresent,
    this.isNfcEnabled,

    this.imsi,
    this.serial,
    this.country,
    this.carrier,
    this.isSimNetworkLocked,
    this.activeMultiSimInfo,
    this.isMultiSim,
    this.numberOfActiveSim,

  });
}   // End of ConnectionValues

List<ConnectionValues> connectionValuesList;                       // array to store ConnectionValues values
ConnectionValues  workingConnectionValues;                       // a working or current ConnectionValues set
int     workingConnectionValuesIndex = 0;                    // index of current plac ein the array
bool workingConnectionValuesChanged;
ConnectionValues defaultConnectionValues = ConnectionValues(
  key: "132456798",
  sequenceNo: workingConnectionValuesIndex + 1,
  dateTimeInt: DateTime.now().millisecondsSinceEpoch,
  dateTimeText: "Date time Text",
  lat: 0.0,
  lng: 0.0,
  locationText: "location text",
  isNetworkAvailable: false,
  networkType: "Network type",
  iPv4Address: "0.0.0.0",
  iPv6Address: "0.0.0.0",
  isWifiEnabled: false,
  wifiSSID: "wifi ssid" ,
  wifiBSSID: "wifi B ssid" ,
  wifiLinkSpeed: "speed",
  wifiMAC: "MAC",

  isNfcEnabled: false,
  isNfcPresent: false,

  imsi: "imsi",
  serial: "123456",
  country: "UK",
  carrier: "carrier ",
  isSimNetworkLocked: true,
  activeMultiSimInfo: "info",
  isMultiSim: false,
  numberOfActiveSim: "1",
  );