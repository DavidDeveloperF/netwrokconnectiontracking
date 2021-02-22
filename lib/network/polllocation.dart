import 'package:location/location.dart';
import 'package:networkconnectiontracking/main_variables.dart';
import 'package:networkconnectiontracking/utils/utilities.dart';
//############################################################################## Refresh current lat/lng
// refreshLocation - gets the current location, updated
//##############################################################################
void refreshLocation() {
  whereAmI = "_refreshLocation";

  myDebugPrint("About to test current location ", whereAmI, false);
  try {
    var then = _getLocation().then((value) {
      // this 'then' waits for the Future
      currentLat = value.latitude;
      currentLng = value.longitude;
      currentLocationText =
          "Location: lat: " + currentLat.toStringAsFixed(4) + " / lng: " +
              currentLng.toStringAsFixed(4);
      myDebugPrint(
          "Received current location as >> " + currentLocationText
          , whereAmI,  false);
    }); // end of then
  } catch (e) {
    myDebugPrint("ERROR :" +  e.toString()
        , whereAmI, false);
    }
} // end of _refreshLocation

// #############################################################################
// Future _getLocation  awaits location response from device
// #############################################################################
Future<LocationData> _getLocation() async {
  Location _localLocation = new Location();
  // _locationData is a local variable - may have nothing until 'await'
  var _locationData = await _localLocation.getLocation();
  return _locationData;
}
