// external
import 'package:flutter/material.dart';
import 'package:android_device_info/android_device_info.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';
// app code
import 'package:networkconnectiontracking/utils/utilities.dart';
import 'package:networkconnectiontracking/network/network_class.dart';
import 'package:networkconnectiontracking/main_variables.dart';



//  Seems like this widget returns a scrollable column
class NetworkTab extends StatefulWidget {
  @override
  _NetworkTabState createState() => _NetworkTabState();
}

class _NetworkTabState extends State<NetworkTab> {
  var screenData = {};

  @override
  void initState() {
    super.initState();
    _getNetwork();
    _getSIM();
    _getNfc();
  }

  void _getNetwork() async {
    String _whereAmI =   "_getNetwork";
    try {
        final network = await AndroidDeviceInfo().getNetworkInfo();
        setState(() {
          screenData.addAll(network);
        });
      } catch (e) {
        myDebugPrint("The exception thrown is $e", _whereAmI, true);
      }
    } // end of getNetwork
  void _getSIM() async {
    String _whereAmI =   "_getSIM";
    try {
        final SIM = await AndroidDeviceInfo().getSimInfo();
        setState(() {
          screenData.addAll(SIM);
        });
      } catch (e) {
        myDebugPrint("The exception thrown is $e", _whereAmI, true);
      }
    } // end of getNetwork
  void _getNfc() async {
    String _whereAmI =   "_getNFC";
    try {
        final Nfc = await AndroidDeviceInfo().getNfcInfo();
        setState(() {
          screenData.addAll(Nfc);
        });
      } catch (e) {
        myDebugPrint("The exception thrown is $e", _whereAmI, true);
      }
    } // end of getNetwork


  @override
  Widget build(BuildContext context) {
    //                                                                    if no data, return Circle
    if (screenData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    //                                                                    (implied) else, we HAVE data
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(),
          RowItem('Network Available',  '${screenData['isNetworkAvailable']}'),
          RowItem('Network',            '${screenData['networkType']}'),
          RowItem('iPv4 Address',       '${screenData['iPv4Address']}'),
          RowItem('iPv6 Address',       '${screenData['iPv6Address']}'),
          RowItem('WiFi Enabled',       '${screenData['isWifiEnabled']}'),
          RowItem('WiFi SSID',          '${screenData['wifiSSID']}'),
          RowItem('WiFi BSSID',         '${screenData['wifiBSSID']}'),
          RowItem('WiFi Speed',         '${screenData['wifiLinkSpeed']}'),
          RowItem('Signal strength(Cellular)', '???'),
          RowItem('WiFi MAC',           '${screenData['wifiMAC']}'),
          Divider(),
          RowItem('NFC Present',        '${screenData['isNfcPresent']}'),
          RowItem('NFC Enabled',        '${screenData['isNfcEnabled']}'),
          Divider(),
          RowItem('IMSI',               '${screenData['imsi']}'),
          RowItem('Serial',             '${screenData['serial']}'),
          RowItem('Country',            '${screenData['country']}'),
          RowItem('Carrier',            '${screenData['carrier']}'),
          RowItem('SIM Locked',         '${screenData['isSimNetworkLocked']}'),
          RowItem('activeMultiSimInfo', '${screenData['activeMultiSimInfo']}'),
          RowItem('Multi SIM',          '${screenData['isMultiSim']}'),
          RowItem('Active SIM(s)',      '${screenData['numberOfActiveSim']}'),
          Divider(),
        ],
      ),
    );
  }
}


// ###########################################################################   RowItem
// # this was not part of the source code
// # I have guessed what it should be - a row with the title & result/value
// ###########################################################################
Widget RowItem(String colTitle, String resultString) {
//  String x;
//  int _lengthTitle = colTitle.length;
  int _columnWidth = 45;

  return Row(children: <Widget>[
    Text(colTitle.padRight(_columnWidth)),
    Text(": "),
    Text(resultString),
  ]);
}

// ############################################################################  MyNetworkConnectionDetail
class MyNetworkConnectionDetail extends StatefulWidget {
  @override
  _MyNetworkConnectionDetailState createState() => _MyNetworkConnectionDetailState();
}

class _MyNetworkConnectionDetailState extends State<MyNetworkConnectionDetail> {
  bool isEditAllowed = true; // todo sort this out later
  TextEditingController locationTextEdit = new TextEditingController();


  // ############################################################################   _onWillPop
// # onWillPop
// # Catch BACK button which might not be intended to exit the app
// #
// # you have to wrap the main build Scaffold as follows:
//
//  Widget build(BuildContext context) {
//    return new WillPopScope(
//        onWillPop: _onWillPop,
//        child: Scaffold(
// ############################################################################
  Future<bool> _onWillPop() async {

    if (workingConnectionValuesChanged == null) {
      debugPrint("## ?? onWillPop workingConnectionValuesChanged = null");
      Navigator.of(context).pop(true);
      return false;
    } else {
      if (!workingConnectionValuesChanged) {
        Navigator.of(context).pop(true);
        return false;
      } else {
        return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Exit without saving?'),
            content: new Text(
                'Are you sure you want to this item, without saving changes?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
            false;
      }
    }
  } // end of _onWillPop

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (updateEditControllers()) {
      debugPrint("?? debug InitState updateEditControllers");
    }
  }

  bool updateEditControllers() {
    debugPrint("updateEditControllers EXECUTED !");
    locationTextEdit.text  =  workingConnectionValues.locationText;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    myDebugPrint("connectionValuesList[0] ${connectionValuesList[0].carrier} ${connectionValuesList[0].dateTimeText} ",
        "DetailedChatThreadMenu / build", false);
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
//   Widget build(BuildContext context) {
//     return Scaffold(
          appBar: AppBar(
            title: Text("MyNetworkConnectionDetail " + liveOrTest),
          ),
          body: Column(children: <Widget>[
// my header row                                                                 my header row
            Row(
              children: <Widget>[
                Text("${getLongDateString(DateTime.now())}  "
                    "Current selection: "),
                Text("  item: "),
                Text(
                  (workingConnectionValuesIndex + 1).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(" of "),
                Text(
                  connectionValuesList.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(" "),
// actual body                                                                   actual body
            SwipeGestureRecognizer(
              onSwipeLeft: () {
                swipeLeftOrClickNext();
              },
              onSwipeRight: () {
                swipeRightOrClickPrevious();
              },
//        onSwipeRight() {
//        // DO STUFF WHEN RIGHT SWIPE GESTURE DETECTED
//      },

              child: Container(
                // This works !                     Subtract ~120 to allow for the AppBar
                height: MediaQuery.of(context).size.height - 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          if (updateEditControllers()) Text("threadId: "),
                          Text(
                            workingConnectionValues.key,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
// 0.801                                                     Topic Dropdown     Accidentally changed this to workingConnectionValues
//                         DropChatTopic(),
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: TextField(
//                                 onChanged: (text) {
//                                   workingConnectionValues.description = text;
//                                   workingConnectionValuesChanged = true;
//                                 },
//                                 decoration: InputDecoration(
//                                   labelText: "description",
//                                 ),
//                                 keyboardType: TextInputType.text,
//                                 // expands: true,
//                                 // minLines: 1,
//                                 maxLines: null,
//                                 style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.bold),
//                                 controller: descriptionEdit,
//                               ),
//                             ),
//                           ],
//                         ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                onChanged: (text) {
                                  workingConnectionValues.locationText = text;
                                  workingConnectionValuesChanged = true;
                                },
                                decoration: InputDecoration(
                                  labelText: "locationText",
                                ),
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                controller: locationTextEdit,
                              ),
                            ),
                          ],
                        ),
  // below code copied from class spreadsheet - column M     
                        Row(children: <Widget>[ Text("key: " ) ,  Text(workingConnectionValues.key,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("sequenceNo: " ) ,  Text(workingConnectionValues.sequenceNo.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("dateTimeInt: " ) ,  Text(workingConnectionValues.dateTimeInt.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("dateTimeText: " ) ,  Text(workingConnectionValues.dateTimeText,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("lat: " ) ,  Text(workingConnectionValues.lat.toStringAsFixed(4),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("lng: " ) ,  Text(workingConnectionValues.lng.toStringAsFixed(4),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("locationText: " ) ,  Text(workingConnectionValues.locationText,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("isNetworkAvailable: " ) ,  Text(workingConnectionValues.isNetworkAvailable.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("networkType: " ) ,  Text(workingConnectionValues.networkType,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("isWifiEnabled: " ) ,  Text(workingConnectionValues.isWifiEnabled.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("wifiLinkSpeed: " ) ,  Text(workingConnectionValues.wifiLinkSpeed,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                        Row(children: <Widget>[ Text("wifiSSID: " ) ,  Text(workingConnectionValues.wifiSSID,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                    //    Row(children: <Widget>[ Text("carrier: " ) ,  Text(workingConnectionValues.carrier,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                    //    Row(children: <Widget>[ Text("downloadSpeed: " ) ,  Text(workingConnectionValues.downloadSpeed.toStringAsFixed(4),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                    //    Row(children: <Widget>[ Text("uploadSpeed: " ) ,  Text(workingConnectionValues.uploadSpeed.toStringAsFixed(4),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                    //    Row(children: <Widget>[ Text("speedUnits: " ) ,  Text(workingConnectionValues.speedUnits,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),

                        RaisedButton(
                          child: Text("DELETE !"),
                          color: Colors.red,
                          onPressed: () {
                            deleteConnectionValuesFunction(
                                context, workingConnectionValuesIndex);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (workingConnectionValuesChanged) {
// always use 'Update' as both save and add (using my own key)
                  updateConnectionValues(workingConnectionValues);
// need to Pop back after save
                  Navigator.pop(context); // Go back after Update/Save.
                }
//            AddNewChatThreadFunction(workingWorkout);      // UPDATE!  not save new
              });
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => DetailedChatThreadMenu()));
            },
            tooltip: 'Save',
            child: Icon(Icons.save),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  // ######################################################################
// # 0.30c  DELETE sighting !
// #        MOVED INSIDE _DisplaySightingsListState to access setState
// # 0.34b  now moved inside _DisplaySightingDetailsState so you
// #        can only delete from the detailed menu, not the list
// ############################################################################
// ***************************************************************************  deleteSightingFunction
  void deleteConnectionValuesFunction(BuildContext context, int index) {
    bool isDeleteAllowed = false;
    String deletePromptText =
        "Only the creator of a ChatThread (or an Administrator) can delete it";
    whereAmI = "deleteConnectionValuesFunction";

//    bool sure = false;
    myDebugPrint("index $index about to showDialog"
      , whereAmI, false);

// todo   REINSTATE review the delete authorisation
    // if (isEditAllowed) {
    //   isDeleteAllowed = true;
    //   deletePromptText = "Are you sure you want to delete this item?";
    // } else {
    //   if (currentUser.uid == connectionValuesList[index].createUser) {
    //     isDeleteAllowed = true;
    //     deletePromptText = "Are you sure you want to delete your item?";
    //   }
    // }
    deletePromptText =
        deletePromptText + "\nItem: " 
            + connectionValuesList[index].lat.toStringAsFixed(4) +
            " / "
            + connectionValuesList[index].lat.toStringAsFixed(4);

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: Text(liveOrTest + " Delete?",),
          content: Text(deletePromptText, ),
          actions: <Widget>[
             RaisedButton(
                onPressed: () {
                  myDebugPrint(
                      "** $whereAmI index $index - Pressed #Yes#  - is delete allowed? = $isDeleteAllowed",
                      whereAmI, false);
                  // 0.31c  Fortunately, this WORKS !
                  if (isDeleteAllowed) {
                    String _tempId = connectionValuesList[index].key;
                    myDebugPrint(
                        "** $whereAmI: Delete ${connectionValuesList[index].locationText} at $index attempted.try"
                            " id: ${connectionValuesList[index].key}",
                        whereAmI, false);

                    //debugPrint(chatThreadRef.toString());
                    // workoutRef = TestWorkout/
                    //                            Yoga/
                    //  workoutRef.child(_chatThread.type + '/' + _chatThread.threadId).set({
// todo REINSTATE DATABASE CALL HERE
//                     chatThreadRef
//                         .child(connectionValuesList[index].threadId)
//                         .remove()
//                         .then((_) {
//                       // 0.34f  KEEP delete logs
//                       myDebugPrint(
//                           "Delete $_tempId at $index successful ${connectionValuesList[index].locationText} ",
//                           whereAmI, false);
//                       //  this is part of .then, so delete will have been completed
//                       setState(() {
//                         //  remove the entry from the List (to match the database)
//                         connectionValuesList.removeAt(index);
//                         //  now move to previous entry in the List (to match the database)
//                         if (workingConnectionValuesIndex > 0) {
//                           workingConnectionValuesIndex =
//                               workingConnectionValuesIndex - 1;
//                         } else {
//                           workingConnectionValuesIndex = 0;
//                         }
//                         // And finally refresh the detailed screen
//                         workingConnectionValues =
//                         connectionValuesList[workingConnectionValuesIndex];
//                       }); // end of setSate
//                     }).catchError((onError) {
//                       myDebugPrint(
//                           "** FAILED !! ** Couldn't delete **  - *** error: ${onError.toString()}",
//                           whereAmI);
//                       myDebugPrint(
//                           "** FAILED ?? ** delete of $_tempId", whereAmI);
//                     }); // end of .then
                  } // end of if allowed
                  Navigator.of(context).pop();
                }, // end of onPressed (Yes)
                child: Text("Yes")),
            new FlatButton(
                onPressed: () {
                  myDebugPrint("index $index - Pressed #No#", whereAmI, false );
                  Navigator.of(context).pop();
                },
                child: Text("No")),
          ],
        ));
  } // end of _deleteMenuItem

  // pull out common code from navigator function to allow swipe to use it too
  void swipeRightOrClickPrevious() {
    if (workingConnectionValuesIndex >= 1) {
      // todo:  need to check for changes & save them if required
      // todo:  Do I need to Await this?
      if (workingConnectionValuesChanged) {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Exit without saving?'),
            content: new Text(
                'Are you sure you want to this item, without saving changes?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  debugPrint("cancelled");
                  Navigator.pop(context); // Go back
                },
                child: new Text('No'),
              ),
//                                                               added in SAVE button 0.801a
              new FlatButton(
                onPressed: () {
                  debugPrint("save & proceed");
                  updateConnectionValues(workingConnectionValues);
                  Navigator.pop(context);             // Continue ?
                },
                child: new Text('SAVE'),
              ),
              new FlatButton(
                onPressed: () {
                  workingConnectionValuesChanged = false;
                  Navigator.pop(context); // Go back
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        );
      } // end of if workoutchanged

      // if user wants to abandon changes, then we turn off Changed, ('Yes' above)
      if (!workingConnectionValuesChanged) {
        setState(() {
          workingConnectionValuesIndex = workingConnectionValuesIndex - 1;
          workingConnectionValues = connectionValuesList[workingConnectionValuesIndex];
        });
      } // Do nothing if workoutchanged
    }
  }

  void swipeLeftOrClickNext() {
    if (workingConnectionValuesIndex + 1 < connectionValuesList.length) {
      // todo:  need to check for changes & save them if required
      // todo:  Do I need to Await this?
      if (workingConnectionValuesChanged) {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Exit without saving?'),
            content: new Text(
                'Are you sure you want to this item, without saving changes?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  debugPrint("cancelled");
                },
                child: new Text('No'),
              ),
//                                                               added in SAVE button 0.801a
              new FlatButton(
                onPressed: () {
                  debugPrint("save & proceed");
                  updateConnectionValues(workingConnectionValues);
                  Navigator.pop(context);             // Continue ?
                },
                child: new Text('SAVE'),
              ),
              new FlatButton(
                onPressed: () => workingConnectionValuesChanged = false,
                child: new Text('Yes'),
              ),
            ],
          ),
        );
      } // end of if chatThreadChanged

      // if user wants to abandon changes, then we turn off Changed, ('Yes' above)
      if (!workingConnectionValuesChanged) {
        setState(() {
          workingConnectionValuesIndex = workingConnectionValuesIndex + 1;
          workingConnectionValues = connectionValuesList[workingConnectionValuesIndex];
        });
      } // Do nothing if workoutchanged
    }
  }
}

void updateConnectionValues(ConnectionValues _connection) {
  myDebugPrint("UPDATE" +
      _connection.key +" / " +
      _connection.dateTimeText +" / " +
      _connection.lat.toStringAsFixed(4) +" / " +
      _connection.lng.toStringAsFixed(4) +" / "
  , "** $whereAmI ", false);
}