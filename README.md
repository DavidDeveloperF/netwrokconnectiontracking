# networkconnectiontracking

Keep track of network signal strength and plot on the map

## Getting Started

ToDO: Setting up background activities = https://pub.dev/packages/workmanager
        blog post about it - https://medium.com/vrt-digital-studio/flutter-workmanager-81e0cfbd6f6e

More work
    todo:   include onWillPop - to trap accidental exits
    todo:   Login menu - can't user Firebase without it
    todo:   onFirstthingy & splash screens (and user preferences)
    todo:   Maps and get map API code
    todo: Can I fix this? >> Plugin project :location_web not found. Please update settings.gradle.


Ver 1.0.1+3  Commit local AND to Github
===========
OK roughtly working now
    refreshLocation taken from WATD and put in it's own polllocation.dart file
        Note: _getLocation function returns type LocationData, not type Location
    refresh called at start of getNetwork
        checks permission first - if no location permission, refreshLocation is turned off
        if permission granted, then will always check location
    not sure what's happening with SIM permissions - need to test on more devices

NEW - MyConnectionListMenu very simple list builder
    cloned from WATD release_menu

    A few changes to the organisation & updates to workingConnection & ...List

    TODO: will probably want to turn off some of the debug logs - once I've tried other devices

Ver 1.0.1+2
============
    Loads of errors reported, so time for
        Flutter Clean
        exit SDK
        restart & start new VMD emulator
    let's test on a Pixel 3 this time... [Loads of problems with Pixel 4]
        Pixel 3 showing wrong time of day 31:35 is has 06:17 ???
        tried changing location to Sheen Gate
        this is Android 10, so lots more logging - see EXCEL

Bugs:   look like the detail display is only looking at workingCV and that alawys has default values
    - check swipe left/right    - LOOKS OK ??
        added to temp debug code to update location and see what displays
        todo: still getting obscure error on SIM card permission
going to Commit anyway.... (just in case - laptop has no battery fitted tonight)

Ver 1.0.1+1
============

OK - did the stpes below and about to save/commit BEFORE I actually try running the firebase stuff
todo:  Android 8.0 - so the Nexus 5x - asked for permission to phone and permission for location    GOOD
todo:  on Nexus seems like the Network widget works
todo:  on Nexus the NetworkDetails is NOT working - seems to only be displaying default values

FIREBASE --- FIREBASE ---FIREBASE --- FIREBASE ---FIREBASE --- FIREBASE ---FIREBASE --- FIREBASE ---FIREBASE --- FIREBASE ---

Add firebase db - I want two main components
    * Authentication        [Note the Firebase helper only works for Android, not flutter]
    * Realtime Database           'cannot find the android application module... '

todo:   I need to check my notes to see how I did it before in Flutter

i)  create new db on firebase console
ii) turn on authentication (i'm only using email+password)
ii) create realtiem db - location Europe (Belgium)
iv) add app to db permissions
    ap name is from android/app/build.grade
    com.frewconsulting.networkconnectiontracking
v)  download google-service.json
    store same place as build.gradle
        android/app/build.grade
    make sure it's correctly named - download is likely to append ' (6)' or similar
vi) make sure flutter packages in pubspec.yaml
      firebase_core: ^0.4.4+3           # I have this in flutter_map
      firebase_auth: ^0.16.0            # Firebase authentication (user login)
      firebase_dynamic_links: ^0.5.1    # 0.22c also part of the sample code for signin
      firebase_database: ^3.1.6         # realtime database
vii) Google instructions says to update SDK as follows:
    The Google services plugin for Gradle loads the google-services.json file you just downloaded. Modify your build.gradle files to use the plugin.

  a Project-level build.gradle (<project>/build.gradle):

    buildscript {
      repositories {
        // Check that you have the following line (if not, add it):
        google()  // Google's Maven repository                          <<< already present
      }
      dependencies {
        ...
        // Add this line
        classpath 'com.google.gms:google-services:4.3.5'                <<< added this
      }
    }

  b allprojects {
      ...
      repositories {
        // Check that you have the following line (if not, add it):
        google()  // Google's Maven repository
        ...
      }
    }
    App-level build.gradle (<project>/<app-module>/build.gradle):


   c apply plugin: 'com.android.application'
    // Add this line
    apply plugin: 'com.google.gms.google-services'                      <<< added this
    dependencies {
      // Import the Firebase BoM
      implementation platform('com.google.firebase:firebase-bom:26.5.0')

      // Add the dependencies for the desired Firebase products
      // https://firebase.google.com/docs/android/setup#available-libraries
    }
    By using the Firebase Android BoM, your app will always use compatible Firebase library versions. Learn more
    Finally, press "Sync now" in the bar that appears in the IDE:


Ver 1.0.1+0
============
Tidy up some of the code - move most of the test buttons out of 'main' into test_menu.dart
Tidy up default Tracking and Connection values
tidy up debugging in network_menu.dart
put a flag on debugging & make sure session and connection exist in pollnetwork.dart
*New session_menu.dart
added in workmanager (batch scheduling) to pubspec.yaml

Version 1.0.0+4
===============
sort of working... problems with accessing SIM details
    network function oK-ish.  It create workingConnectionValues & adds to connectionValuesList
    basic screen to view and scroll through connectionValuesList

todo: push to github        [ lots of problems with authentication]
        New install of Git code may have worked ??
DONE: fix the screen/display version [no longer using the getAll routine - I need to use setState]
DONE: integrate network, SIM, location
todo: integrate speedtest
DONE: update the session and values classes [ SEE EXCEL ]
todo: can I suppress the huge amount of logging in the speedtest?


*   Pixel 3 and Nexus 5X both working, but they do generate lots and lots more logging
    (API 29 10)  26/8.0

??  Pixel 4 seemed to flash up a prompt about 'Allow USB debugging'
    - this might be why I can't use it in SDK
    - struggling to find the setting
        https://my-techspace.com/how-to-enable-usb-debugging-and-developer-options-on-android-11/
    - device keeps freezing and popping up 'not responding' msg
    - tried Restart (using ~90% of laptop CPU ... for about 45mins ! )

+   I created a new Firebase RTDB, need to document this before I forget
    >> not implemented in the app yet.
    >> only created in firebase console
        Authentication - email/password only
        Location - Belgium (only US and EU available)
        Rule - TEST MODE (all authenticated users can read/write)
        https://networkconnectiontracking-default-rtdb.europe-west1.firebasedatabase.app/
    todo: get jSON codes to allow app Firebase access

Version 1.0.0+3
===============
- wasted a LOT of time on SDK and flutter problems. See NEVER UPDATE SDK.TXT
- seems possible that flutter no longer allows definitions (eg String) in the body of stateful

OK now working:
    + New myDebugPrint    - standard output format, easy to get results
                          ? TODO: build Firebase version
    + new getSensorInfo   + also SensorInfo class (don't actually have much use for this)
    + getAllData          + working in background,
                          - not working on screen (because I removed setState )
    todo:  location info not working (on emulator) - permission? unsupported function?
    todo:  SIM data and permissions needs real testing

Version 1.0.0+2
===============
roughly working (on emulator) - try it on a real device
    - doesn't get SSID from Wifi
    - doesn't get anything from SIM
    - did not ask for permission to use location

##  lots of problems getting Pixel 4 (API 30 android 11) to connect to SDK ???
    seems to be quite happy with Pixel 3 (29/10) ?

Version 1.0.0+1
===============
add android_device_info to pubspec.yaml... Flutter plugin to get device information on Android devices.

implemented apis
    Device getDeviceInfo()      ?? this is not at same level
    Memory getMemoryInfo()      << memory
    Battery getBatteryInfo()    << battery
    Sensors getSensorInfo()
    Network getNetworkInfo()    << network
    Display getDisplayInfo()
    NFC getNfcInfo()            << NFC
    SIM getSimInfo()            << SIM
    Config getConfigInfo()
    Location getLocationInfo()  << Location ??
    ABI getAbiInfo()
    Fingerprint getFingerprintInfo()

Also need to set up permissions - Add required permissions to:

    <your project>/android/app/src/main/AndroidManifest.xml

<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" /> <!-- Network Info -->
<uses-permission android:name="android.permission.INTERNET" /> <!-- Network Info -->
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" /> <!-- WiFI Info -->
<uses-permission android:name="android.permission.READ_PHONE_STATE" /> <!-- SIM Info / Phone # -->
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" /> <!-- Location Info -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" /> <!-- Location Info -->
<uses-permission android:name="android.permission.USE_FINGERPRINT" /> <!-- Fingerprint Info -->

borrowed the network_menu code from here [BTW: this is dreadful code for example: memory = ..getNetworkInfo() ]
    https://stackoverflow.com/questions/62395540/how-identify-the-cellular-or-mobile-network-signal-strength

This also includes code to test internet speed (Answer 1) using
    https://pub.dev/packages/internet_speed_test

    internetSpeedTest.startDownloadTesting(
                  onDone: (double transferRate, SpeedUnit unit) {
                    // TODO: Change UI                    },
                  onProgress: (double percent, double transferRate, SpeedUnit unit) {
                    // TODO: Change UI
                    setState(() {
                      if (unit == SpeedUnit.Kbps) {
                        speed = transferRate.toStringAsPrecision(3) + ' Kbps';                }
                      if (unit == SpeedUnit.Mbps) {
                        speed = transferRate.toStringAsPrecision(3) + ' Mbps';                }
                    });                                                                           },
                  onError: (String errorMessage, String speedTestError) {
                    // TODO: Show toast error                                                  },
                  //  testServer: fetchLatestAppVersionCodeUri.toString(),
                  //Your test server URL goes here,
                );