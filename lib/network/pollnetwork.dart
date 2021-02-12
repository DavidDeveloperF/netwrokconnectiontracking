import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_device_info/android_device_info.dart';
import 'network_class.dart';


//  Seems like this widget returns a scrollable column
void getNetworkFunction(){
    getNetworkData();
  }

void getNetworkData() async {
  var data = {};
    workingConnectionValues = defaultConnectionValues;

    debugPrint("**** getNetworkData async function " + DateTime.now().toString());

    final memory = await  AndroidDeviceInfo().getMemoryInfo();

    debugPrint("about to get network info");
    final network = await AndroidDeviceInfo().getNetworkInfo();
    debugPrint("about to get NFC info");
    final display = await AndroidDeviceInfo().getNfcInfo();
    debugPrint("about to get SIM info");
    var sim = await AndroidDeviceInfo().getSimInfo();

    data.addAll(memory);
    data.addAll(network);
    data.addAll(display);
    data.addAll(sim);

    debugPrint(data.toString());
    //
    // if (mounted) {
    //   setState(() {
    //     this.data = data;
    //   });
    // }

    var permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    if (permission == PermissionStatus.denied) {
      var permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.phone]);
      if (permissions[PermissionGroup.phone] == PermissionStatus.granted) {
        sim = await AndroidDeviceInfo().getSimInfo();
        data.addAll(sim);
        // if (mounted) {
        //   setState(() {
        //     this.data = data;
        //   });
        }
      }
    }




          // RowItem('Network Available', '${data['isNetworkAvailable']}'),
          // RowItem('Network', '${data['networkType']}'),
          // RowItem('iPv4 Address', '${data['iPv4Address']}'),
          // RowItem('iPv6 Address', '${data['iPv6Address']}'),
          // RowItem('WiFi Enabled', '${data['isWifiEnabled']}'),
          // RowItem('WiFi SSID', '${data['wifiSSID']}'),
          // RowItem('WiFi BSSID', '${data['wifiBSSID']}'),
          // RowItem('WiFi Speed', '${data['wifiLinkSpeed']}'),
          // RowItem('Signal strength(Cellular)', '???'),
          // RowItem('WiFi MAC', '${data['wifiMAC']}'),
          // Divider(),
          // RowItem('NFC Present', '${data['isNfcPresent']}'),
          // RowItem('NFC Enabled', '${data['isNfcEnabled']}'),
          // Divider(),
          // RowItem('IMSI', '${data['imsi']}'),
          // RowItem('Serial', '${data['serial']}'),
          // RowItem('Country', '${data['country']}'),
          // RowItem('Carrier', '${data['carrier']}'),
          // RowItem('SIM Locked', '${data['isSimNetworkLocked']}'),
          // RowItem('activeMultiSimInfo', '${data['activeMultiSimInfo']}'),
          // RowItem('Multi SIM', '${data['isMultiSim']}'),
          // RowItem('Active SIM(s)', '${data['numberOfActiveSim']}'),
          // Divider(),




