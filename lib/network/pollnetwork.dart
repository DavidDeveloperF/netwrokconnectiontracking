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

