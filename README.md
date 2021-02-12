# networkconnectiontracking

Keep track of network signal strength and plot on the map

## Getting Started


Version 1.0.0+1
===============
add android_device_info to pubspec.yaml... Flutter plugin to get device information on Android devices.

implemented apis
    Device getDeviceInfo()
    Memory getMemoryInfo()
    Battery getBatteryInfo()
    Sensors getSensorInfo()
    Network getNetworkInfo()
    Display getDisplayInfo()
    NFC getNfcInfo()
    SIM getSimInfo()
    Config getConfigInfo()
    Location getLocationInfo()
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

borrowed the network_menu code from here
    https://stackoverflow.com/questions/62395540/how-identify-the-cellular-or-mobile-network-signal-strength

