import 'package:flutter/material.dart';
import 'package:networkconnectiontracking/network/network_class.dart';
import 'package:networkconnectiontracking/utils/utilities.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

import '../main_variables.dart';

class MySessionMenu extends StatefulWidget {
  @override
  _MySessionMenuState createState() => _MySessionMenuState();
}

class _MySessionMenuState extends State<MySessionMenu> {
String wereAmI = "_MySessionMenuState";
bool isEditAllowed = true; // todo sort this out later
TextEditingController aCommentEdit = new TextEditingController();


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

  if (workingTrackerSessionChanged == null) {
    debugPrint("## ?? onWillPop workingTrackerSessionChanged = null");
    Navigator.of(context).pop(true);
    return false;
  } else {
    if (!workingTrackerSessionChanged) {
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
  //debugPrint("updateEditControllers EXECUTED !");
  aCommentEdit.text  =  workingTrackerSession.aComment;
  return true;
}

@override
Widget build(BuildContext context) {
  return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
//   Widget build(BuildContext context) {
//     return Scaffold(
        appBar: AppBar(
          title: Text("My Session Menu "+appVersion +liveOrTest),
        ),
        body: Column(children: <Widget>[
// my header row                                                                 my header row
          Row(
            children: <Widget>[
              Text("${getLongDateString(DateTime.now())}  "
                  "Current selection: "),
              Text("  item: "),
              Text(
                (workingTrackerSessionIndex + 1).toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(" of "),
              Text(
                trackerSessionList.length.toString(),
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
                          workingTrackerSession.key,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
// 0.801                                                     Topic Dropdown     Accidentally changed this to workingTrackerSession
//                         DropChatTopic(),
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: TextField(
//                                 onChanged: (text) {
//                                   workingTrackerSession.description = text;
//                                   workingTrackerSessionChanged = true;
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
                                workingTrackerSession.aComment = text;
                                workingTrackerSessionChanged = true;
                              },
                              decoration: InputDecoration(
                                labelText: "Comments",
                              ),
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              controller: aCommentEdit,
                            ),
                          ),
                        ],
                      ),
                      // below code copied from class spreadsheet - column M
                      Row(children: <Widget>[ Text("key: " ) ,  Text(workingTrackerSession.key,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("dateTimeText: " ) ,  Text(workingTrackerSession.dateTimeText,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("dateTimeInt: " ) ,  Text(workingTrackerSession.dateTimeInt.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("locationText: " ) ,  Text(workingTrackerSession.locationText,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("deviceId: " ) ,  Text(workingTrackerSession.deviceId,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("deviceDescription: " ) ,  Text(workingTrackerSession.deviceDescription,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("userId: " ) ,  Text(workingTrackerSession.userId,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("appName: " ) ,  Text(workingTrackerSession.appName,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("appVersion: " ) ,  Text(workingTrackerSession.appVersion,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("imsi: " ) ,  Text(workingTrackerSession.imsi,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("serial: " ) ,  Text(workingTrackerSession.serial,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("country: " ) ,  Text(workingTrackerSession.country,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("carrier: " ) ,  Text(workingTrackerSession.carrier,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("batteryPercent: " ) ,  Text(workingTrackerSession.batteryPercent.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("refreshRate: " ) ,  Text(workingTrackerSession.refreshRate.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("aComment: " ) ,  Text(workingTrackerSession.aComment,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("spareString: " ) ,  Text(workingTrackerSession.spareString,     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),
                      Row(children: <Widget>[ Text("spareInt: " ) ,  Text(workingTrackerSession.spareInt.toString(),     style: TextStyle(       fontWeight: FontWeight.bold,    ),  ),]),

                      RaisedButton(
                        child: Text("DELETE !"),
                        color: Colors.red,
                        onPressed: () {
                          deleteConnectionValuesFunction(
                              context, workingTrackerSessionIndex);
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
              if (workingTrackerSessionChanged) {
// always use 'Update' as both save and add (using my own key)
                updateTrackerSession(workingTrackerSession);
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
  //   if (currentUser.uid == trackerSessionList[index].createUser) {
  //     isDeleteAllowed = true;
  //     deletePromptText = "Are you sure you want to delete your item?";
  //   }
  // }
  deletePromptText =
      deletePromptText + "\nItem: "
          + trackerSessionList[index].lat.toStringAsFixed(4) +
          " / "
          + trackerSessionList[index].lat.toStringAsFixed(4);

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
                  String _tempId = trackerSessionList[index].key;
                  myDebugPrint(
                      "** $whereAmI: Delete ${trackerSessionList[index].locationText} at $index attempted.try"
                          " id: ${trackerSessionList[index].key}",
                      whereAmI, false);

                  //debugPrint(chatThreadRef.toString());
                  // workoutRef = TestWorkout/
                  //                            Yoga/
                  //  workoutRef.child(_chatThread.type + '/' + _chatThread.threadId).set({
// todo REINSTATE DATABASE CALL HERE
//                     chatThreadRef
//                         .child(trackerSessionList[index].threadId)
//                         .remove()
//                         .then((_) {
//                       // 0.34f  KEEP delete logs
//                       myDebugPrint(
//                           "Delete $_tempId at $index successful ${trackerSessionList[index].locationText} ",
//                           whereAmI, false);
//                       //  this is part of .then, so delete will have been completed
//                       setState(() {
//                         //  remove the entry from the List (to match the database)
//                         trackerSessionList.removeAt(index);
//                         //  now move to previous entry in the List (to match the database)
//                         if (workingTrackerSessionIndex > 0) {
//                           workingTrackerSessionIndex =
//                               workingTrackerSessionIndex - 1;
//                         } else {
//                           workingTrackerSessionIndex = 0;
//                         }
//                         // And finally refresh the detailed screen
//                         workingTrackerSession =
//                         trackerSessionList[workingTrackerSessionIndex];
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
  if (workingTrackerSessionIndex >= 1) {
    // todo:  need to check for changes & save them if required
    // todo:  Do I need to Await this?
    if (workingTrackerSessionChanged) {
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
                updateTrackerSession(workingTrackerSession);
                Navigator.pop(context);             // Continue ?
              },
              child: new Text('SAVE'),
            ),
            new FlatButton(
              onPressed: () {
                workingTrackerSessionChanged = false;
                Navigator.pop(context); // Go back
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      );
    } // end of if workoutchanged

    // if user wants to abandon changes, then we turn off Changed, ('Yes' above)
    if (!workingTrackerSessionChanged) {
      setState(() {
        workingTrackerSessionIndex = workingTrackerSessionIndex - 1;
        workingTrackerSession = trackerSessionList[workingTrackerSessionIndex];
      });
    } // Do nothing if workoutchanged
  }
}

void swipeLeftOrClickNext() {
  if (workingTrackerSessionIndex + 1 < trackerSessionList.length) {
    // todo:  need to check for changes & save them if required
    // todo:  Do I need to Await this?
    if (workingTrackerSessionChanged) {
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
                updateTrackerSession(workingTrackerSession);
                Navigator.pop(context);             // Continue ?
              },
              child: new Text('SAVE'),
            ),
            new FlatButton(
              onPressed: () => workingTrackerSessionChanged = false,
              child: new Text('Yes'),
            ),
          ],
        ),
      );
    } // end of if chatThreadChanged

    // if user wants to abandon changes, then we turn off Changed, ('Yes' above)
    if (!workingTrackerSessionChanged) {
      setState(() {
        workingTrackerSessionIndex = workingTrackerSessionIndex + 1;
        workingTrackerSession = trackerSessionList[workingTrackerSessionIndex];
      });
    } // Do nothing if workoutchanged
  }
}
}

void updateTrackerSession(TrackerSession _session) {
  myDebugPrint("UPDATE" +
      _session.key +" / " +
      _session.dateTimeText +" / " +
      // _session.lat.toStringAsFixed(4) +" / " +
      // _session.lng.toStringAsFixed(4) +" / "
      "\\", "** $whereAmI ", false);
}