class MyDebugLog{

  String key;                       // date/time now in millisecs
  String aLoggedText;               // leading 'a' so this is 1st field
  String whereFrom;                 // module or calling routine
  String createDate;                // long string format
  String appVersion;                // version and build
  String createUser;                // user id
  String createName;                // user's display name
  String createDevice;              // device id
  double createLat;                 // lat
  double createLng;                 // long
  String region;                    // if applicable
  bool isTestUser;                  // based on user type

  MyDebugLog({
    this.key,
    this.aLoggedText,
    this.whereFrom,
    this.createDate,
    this.appVersion,
    this.createUser,
    this.createName,
    this.createDevice,
    this.createLat,
    this.createLng,
    this.region,
    this.isTestUser,
  });
}

List<MyDebugLog> myDebugLogList;                       // array to store MyDebugLog values
MyDebugLog       workingMyDebugLog;                    // a working or current MyDebugLog set
int              workingMyDebugLogIndex;               // integer index of current place in the array
bool             workingMyDebugLogChanged;             // bool to flag whether working___ has been changed
