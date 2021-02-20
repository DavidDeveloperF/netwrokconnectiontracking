//
//  Network and version values
//
//import 'package:flutter/material.dart';
import 'package:intl/intl.dart';                    // date formats
// my code

// core data               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
String currentUser   = "dummy userId";            // user id
String currentName   = "dummy user name";         // user's display name
String currentDeviceId = "dummy deviceId";        // device id
String currentDeviceDetails = "device ???";       // device id
String currentRegion = "n/a";                     // if applicable
double currentLat    = 0.28;                      // lat
double currentLng    = -0.47;                     // long
String currentLocationText = "unknown location";

// date formats for logging and display            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
final String  appDateFmt      = "EEE dd-MMM-yy HH:mm";
final String  appDateFmtShort = "EEE HH:mm";
const int longFutureDate = 9000111222333;   // used to create descending date keys


// internet speeds           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
double currentDownloadSpeed = 3.14159;
double currentUploadSpeed   = 3.14159;
String downloadProgress = '0';
String uploadProgress = '0';
String currentSpeedUnits = " Mbps";

// Firebase ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bool isFirebaseDBUsed = false;         // don't try to use db if not implemented


// build and package data  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
String appName        = "Network Connection Tracker";
String appVersion     = "??";
String appPackageName = "package name";
String appBuildNumber = "package build number";

// debug logging            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
String whereAmI       = "debug location not set";
final bool printDebugMessage    = true;
final bool logDebugMessage      = false;
String liveOrTest = "";                     // append to AppBar title "" or "Test"



// #############################################################################  Core functions

// #############################################################################
// # getAgeInMinAsString(double _minutes)
// # Convert minutes to a String time as mins/hours/days
// #############################################################################
String getAgeInMinAsString(double _minutes) {
  String resultString = "failed";
  if (_minutes < 120) {
    resultString =    _minutes.toStringAsFixed(0) + " mins";
  } else {
    if (_minutes < 1200) {
      resultString =  (_minutes / 60).toStringAsFixed(0) +
          " hrs";
    } else {
      resultString =  (_minutes / 60 / 24).toStringAsFixed(0) + " days";
    }
  }
  return resultString;
}

// ############################################################## MY UTILITIES: Date format
// ############################################################## MY UTILITIES: Date format
// ############################################################## MY UTILITIES: Date format
// getDateFromInt   get a Date/Time from integer time (in millisecs)
DateTime getDateFromInt(int dateTimeInt) {
  return DateTime.fromMillisecondsSinceEpoch(dateTimeInt);}

// getShortDateStringFromDate   get a string from Date/Time
String getShortDateStringFromDate(DateTime dateTime) {
  return new DateFormat(appDateFmtShort).format(dateTime);}

// getShortDateStringFromInt    get a string from integer time (in millisecs)
String getShortDateStringFromInt(int dateTimeInt) {
  DateTime _dt = DateTime.fromMillisecondsSinceEpoch(dateTimeInt);
  return new DateFormat(appDateFmtShort).format(_dt);}

// getLongDateString            get a long format string from Date/Time
String getLongDateString(DateTime dateTime) {
  return DateFormat(appDateFmt).format(dateTime);}
//  ICU Name                   Skeleton
//  --------                   --------
//  DAY                          d
//  ABBR_WEEKDAY                 E
//  WEEKDAY                      EEEE
//  ABBR_STANDALONE_MONTH        LLL
//  STANDALONE_MONTH             LLLL
//  NUM_MONTH                    M
//  NUM_MONTH_DAY                Md
//  NUM_MONTH_WEEKDAY_DAY        MEd
//  ABBR_MONTH                   MMM
//  ABBR_MONTH_DAY               MMMd
//  ABBR_MONTH_WEEKDAY_DAY       MMMEd
//  MONTH                        MMMM
//  MONTH_DAY                    MMMMd
//  MONTH_WEEKDAY_DAY            MMMMEEEEd
//  ABBR_QUARTER                 QQQ
//  QUARTER                      QQQQ
//  YEAR                         y
//  YEAR_NUM_MONTH               yM
//  YEAR_NUM_MONTH_DAY           yMd
//  YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
//  YEAR_ABBR_MONTH              yMMM
//  YEAR_ABBR_MONTH_DAY          yMMMd
//  YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
//  YEAR_MONTH                   yMMMM
//  YEAR_MONTH_DAY               yMMMMd
//  YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
//  YEAR_ABBR_QUARTER            yQQQ
//  YEAR_QUARTER                 yQQQQ
//  HOUR24                       H
//  HOUR24_MINUTE                Hm
//  HOUR24_MINUTE_SECOND         Hms
//  HOUR                         j
//  HOUR_MINUTE                  jm
//  HOUR_MINUTE_SECOND           jms
//  HOUR_MINUTE_GENERIC_TZ       jmv
//  HOUR_MINUTE_TZ               jmz
//  HOUR_GENERIC_TZ              jv
//  HOUR_TZ                      jz
//  MINUTE                       m
//  MINUTE_SECOND                ms
//  SECOND                       s
