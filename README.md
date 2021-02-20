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

version: 1.0.1+0
===============
1) tidy up getNetwork

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