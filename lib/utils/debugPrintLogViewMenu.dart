import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:networkconnectiontracking/main_variables.dart';
import 'package:networkconnectiontracking/utils/mydebuglog_class.dart';
import 'package:networkconnectiontracking/utils/utilities.dart';


// ############################################################################
class MyDebugPrintMenu extends StatefulWidget {
  @override
  _DebugPrintMenuState createState() => _DebugPrintMenuState();
}

class _DebugPrintMenuState extends State<MyDebugPrintMenu> {
  // debugLogLocation
  String whereAmI = "_DebugPrintMenuState";
// 0.33c        Only just added 'isTestUser' field, so expect lots of nulls
  bool _isTestUser = false;
  String _createName;
  String whereFrom30;
  List<MyDebugLog> debugLogList = new List<MyDebugLog>();

  @override
  void initState() {
    super.initState();
    // todo: check user is logged in....
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Debug posts (ver: $appVersion)'),
        actions: [
          IconButton(
            icon: Icon(Icons.backspace),
            onPressed: () {
              Navigator.pop(context); // Go back - comes from settings.
//            Navigator.push(context,
//              MaterialPageRoute(builder: (context) => SettingsTopMenu()));
            }, // onPressed
          )
        ], //actions
      ),
      // *************************************************************************  body
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              // ############################################################## fixed header row
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Header: TODO fit a filter or search here",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Icon(Icons.filter_list),
                  ]),
              //################################################################ scrolling Listview
              // Expanded to make sure the StreamBuilder doesn't overflow
              Expanded(
                child: StreamBuilder(
                    stream: debugLogLocation
                        .onValue,
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      String whereAmI = "_DebugPrintMenuState - StreamBuilder";

                      // if no data, then circle                                  << no data
                      if (!snapshot.hasData) {
                        debugPrint("** $whereAmI - ** NO DATA ... yet");
                        return CircularProgressIndicator();
                      }
                      // note that the above *returns*, so we have implied 'else'      with Data

                      Map<dynamic, dynamic> snapResult =
                          snapshot.data.snapshot.value;

                      debugLogList.clear();
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> LOOP
                      snapResult.forEach((key, value) {
                        // loop data + add to List
                        // if any missing data or nulls, correct them here

// 0.33c        Only just added 'isTestUser' field, so expect lots of nulls
                        if (value['whereFrom'] == null) {
                          _isTestUser = false;
                        } else {
                          _isTestUser = value['isTestUser'];
                        }
// 0.35a        Realised user does not always set a dispaly name
                        if (value['createName'] == null) {
                          _createName = currentUser.email;
                        } else {
                          _createName = value['createName'];
                        }

                        whereFrom30 = value['whereFrom'] + '                              ';
                        whereFrom30 = whereFrom30.substring(0,30);
                        debugLogList.add(MyDebugLog(
                          // DONE: watch out for null values  ^^^ above
                          key:          key,
                          aLoggedText:  value['aLoggedText'],
                          appVersion:   value['appVersion'],
                          createDevice: value['createDevice'],
                          createDate:   value['createDate'],
                          // any unknown value becomes 3.14159
                          createLat:
                              double.tryParse(value["createLat"].toString()) ??
                                  3.14159,
                          createLng:
                              double.tryParse(value["createLng"].toString()) ??
                                  3.14159,
                          createName:   _createName,
                          createUser:   value['createUser'],
                          region:       value['region'],
                          whereFrom:    whereFrom30,
// 0.33c        Only just added 'isTestUser' field, so expect lots of nulls
                          isTestUser:   _isTestUser,
                        )); // end of Add
                      }); // end of forEach

//  >>>>>>>>>>>>>>>>>> snapshot has returned data
//  >>>>>>>>>>>>>>>>>> data loaded into ~~~List
//  >>>>>>>>>>>>>>>>>> sort the data in ~~~List by sortKey
                      debugLogList.sort((a, b) => a.key.compareTo(b
                          .key)); // LIST SORT (on the above combined sort field)

//                      for (int i=0; i<menuItemsList.length; i++) {
//                        debugPrint("** $whereAmI check sort. Key: ${menuItemsList[i].sortKey} Category:${menuItemsList[i].category} Item:${menuItemsList[i].title}");
//                      }

                      debugPrint(
                          "total number of debug items: ${debugLogList.length}");

//            return Text("hello world - No of items=${menuItemsList.length}");

                      return new ListView.builder(
                          shrinkWrap: true,
                          itemCount: debugLogList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(color: Colors.deepOrange),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(debugLogList[index].createName,),
                                      subtitle: Text(debugLogList[index].aLoggedText,),
                                      onLongPress: () {
                                        debugPrint(
                                            "user has long pressed $index");
//                                        workingMenuItem = menuItemsList[index];
//                                        workingIndex = index;
//                                        Navigator.push(context,
//                                            MaterialPageRoute(builder: (context) => EditMenuItemsMenuExtended()));
                                      },
                                      leading: CircleAvatar(
                                        radius: 20,
                                        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                          if (debugLogList[index].isTestUser)  Text(" Test"),
                                          if (!debugLogList[index].isTestUser) Text(" Live"),
                                        ],),
//                                        Text(
//                                            "${debugLogList[index].createDate.substring(4, 9)}"),
                                      ),
                                    ),
// 0.33c add in a row of basic details
                                Row(children: <Widget>[
//                                  if (debugLogList[index].isTestUser)  Text("Test"),
//                                  if (!debugLogList[index].isTestUser) Text("Live"),
                                  Text(getLongDateString(translateDateKey(debugLogList[index].key))), Text(" "),
                                  Text(debugLogList[index].appVersion +
                                      " || " +debugLogList[index].whereFrom),
                                ],),
                                  ],
                                ),
                              ),
                            );
                          }); // end of builder executable
                    }),
              ),
            ],
          ),
        ),
      ),

      // ##########################################################################
      // 0.10h Temporary bottom buttons to test current location (and snackbar)
      // ##########################################################################
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 12.5,
          // bottom nav must have at least 2 items
          items: [
            BottomNavigationBarItem(
                icon: debugBotButIcon00,
            //    title: Text(debugBottomButtonText00)),
                label: debugBottomButtonText00),
            BottomNavigationBarItem(
                icon: debugBotButIcon01, //title: Text(debugBottomButtonText01)),
                label: debugBottomButtonText00),
            BottomNavigationBarItem(
                icon: debugBotButIcon02, //title: Text(debugBottomButtonText02)),
                label: debugBottomButtonText00),
          ],
          // notice the bottom navigator only calls one function (passing index for the option)
          onTap: (int index) {
            //              debugPrint('$_localAppCode Tapped item: $index');
            debugBottomNavFunction(index);
          }),
    );
  }

  // ########################################################### 0.22e debug bottom method
  debugBottomNavFunction(int index) {
    final String _function = "mapBottomNavFunction";

    switch (index) {
      case 0: // Remember, the index starts at ZERO
        debugPrint('$_function 0) Tapped item: $index');
//       0.11b - moved to 'refresh' in appBar
//        _refreshLocation();
//       0.11b - allow user to access map settings here (from the map)
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => DropDownMenu()));
        break;
      case 1:
        debugPrint('$_function 1) Tapped item: $index');
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => NewMenu()));
        break;
      case 2:
        debugPrint('$_function 2) Tapped item: $index');
//        initIcons();
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => ReleaseMenu()));
        break;
      default: // ???  REALLY - don't expect to get here
        debugPrint('$_function ..WHAT? Unexpected Tapped item: $index');
        break;
    }
  }
}
