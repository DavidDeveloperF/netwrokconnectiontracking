import 'package:flutter/material.dart';
import 'package:internet_speed_test/internet_speed_test.dart';

import 'package:networkconnectiontracking/main_variables.dart';
import 'package:networkconnectiontracking/utils/utilities.dart';


class MySpeedTestMenu extends StatefulWidget {
  @override
  _MySpeedTestMenuState createState() => _MySpeedTestMenuState();
}

class _MySpeedTestMenuState extends State<MySpeedTestMenu> {
  final internetSpeedTest = InternetSpeedTest();

  initState(){
    whereAmI = "speedtestMenu";
    currentDownloadSpeed = 0.0;
    currentUploadSpeed   = 0.0;
    downloadProgress = '0';
    uploadProgress = '0';
    currentSpeedUnits = 'Mb/s';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appName),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Progress $downloadProgress%'),
                  Text('Download rate  $currentDownloadSpeed $currentSpeedUnits'),
                ],
              ),
              RaisedButton(
                child: Text('start download test'),
                onPressed: () {
                  internetSpeedTest.startDownloadTesting(
                    onDone: (transferRate,  unit) {
                      print('the transfer rate $transferRate');
                      setState(() {
                        currentDownloadSpeed = transferRate;
                        currentSpeedUnits = unit.toString();
                        downloadProgress = '100';
                      });
                    },
                    onProgress:
                        ( percent,  transferRate,  unit) {
                      print(
                          'the transfer rate $transferRate, the percent $percent');
                      setState(() {
                        currentDownloadSpeed = transferRate;
                        currentSpeedUnits = unit.toString();
                        downloadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: ( errorMessage,  speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    testServer: 'http://ipv4.ikoula.testdebit.info/1M.iso',
                    fileSize: 1000000,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Progress $uploadProgress%'),
                  Text('Upload rate  $currentUploadSpeed Kb/s'),
                ],
              ),
              RaisedButton(
                child: Text('start Upload test'),
                onPressed: () {
                  internetSpeedTest.startUploadTesting(
                    onDone: (double transferRate, unit) {
                      print('the transfer rate $transferRate');
                      setState(() {
                        currentUploadSpeed = transferRate;
                        currentSpeedUnits = unit.toString();
                        uploadProgress = '100';
                      });
                    },
                    onProgress:
                        (double percent, double transferRate,  unit) {
                      print(
                          'the transfer rate $transferRate, the percent $percent');
                      setState(() {
                        currentUploadSpeed = transferRate;
                        currentSpeedUnits = unit.toString();
                        uploadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: (String errorMessage, String speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    testServer: 'http://ipv4.ikoula.testdebit.info/',
                    // testServer: 'https://speedtest.takamol.sy.prod.hosts.ooklaserver.net:8080/upload?nocache=a3fd0f07-a5f0-434c-900c-7aa5fd102858&guid=ea24b1a6-eab7-4316-99d1-1971305e05d8',
                    fileSize: 1000000,
                  );
                },
              ),
            ],
          ),
        ),
    );
  }
}

// ############################################################################# backgroundDownload
// # backgroundDownload
// # to be run unattended/without user or screen
// #############################################################################
void backgroundDownload(){
  final internetSpeedTest = InternetSpeedTest();
  whereAmI = "backgroundDownload";
  currentDownloadSpeed = 0.0;
  currentUploadSpeed   = 0.0;
  downloadProgress = '0';
  uploadProgress = '0';
  currentSpeedUnits = 'Mb/s';

  internetSpeedTest.startDownloadTesting(
    onDone: ( transferRate,  unit) {
      currentDownloadSpeed = transferRate;
      currentSpeedUnits = unit.toString();
      myDebugPrint('COMPLETED the transfer rate $transferRate'
          , whereAmI, false);
      },
    onProgress: null,
    // onProgress:  ( percent,  transferRate,  unit) {
    //   currentDownloadSpeed = transferRate;
    //   currentSpeedUnits = unit.toString();
    //   downloadProgress = percent.toStringAsFixed(2);
    //   myDebugPrint('PROGRESS the transfer rate $transferRate, the percent $percent'
    //       , whereAmI, false);
    //   },
    onError: (String errorMessage, String speedTestError) {
      myDebugPrint(
          'the errorMessage $errorMessage, the speedTestError $speedTestError'
          , whereAmI, false);
    },
    testServer: 'http://ipv4.ikoula.testdebit.info/1M.iso',
    fileSize: 1000000,
  );
}// ############################################################################# backgroundUpload
// # backgroundUpload
// # to be run unattended/without user or screen
// #############################################################################
void backgroundUpload(){
  final internetSpeedTest = InternetSpeedTest();
  whereAmI = "backgroundUpload";
  currentDownloadSpeed = 0.0;
  currentUploadSpeed   = 0.0;
  downloadProgress = '0';
  uploadProgress = '0';
  currentSpeedUnits = 'Mb/s';

  internetSpeedTest.startUploadTesting(
    onDone: ( transferRate,  unit) {
      currentUploadSpeed = transferRate;
      currentSpeedUnits = unit.toString();
      myDebugPrint('COMPLETED the transfer rate $transferRate'
          , whereAmI, false);
      },
    onProgress: null,
    // onProgress:  ( percent,  transferRate,  unit) {
    //   currentUploadSpeed = transferRate;
    //   currentSpeedUnits = unit.toString();
    //   downloadProgress = percent.toStringAsFixed(2);
    //   myDebugPrint('PROGRESS the transfer rate $transferRate, the percent $percent'
    //       , whereAmI, false);
    //   },
    onError: (String errorMessage, String speedTestError) {
      myDebugPrint(
          'the errorMessage $errorMessage, the speedTestError $speedTestError'
          , whereAmI, false);
    },
    testServer: 'http://ipv4.ikoula.testdebit.info/',
    fileSize: 1000000,
  );
}