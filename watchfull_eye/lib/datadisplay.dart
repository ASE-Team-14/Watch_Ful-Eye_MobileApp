import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:watchfull_eye/evidence.dart';
import 'package:watchfull_eye/evidencereport.dart';
import 'package:watchfull_eye/main.dart';
import 'package:watchfull_eye/manageuser.dart';

import 'modalclass.dart';
import 'package:http/http.dart' as http;

class WatchData extends StatefulWidget {
  @override
  _WatchDataState createState() => _WatchDataState();
}

class _WatchDataState extends State<WatchData> {
  ScrollController _scrollController = ScrollController();
  double audioLevel = 0.0;
  double hrv = 0.0;
  double heartrate = 0;
  double spo2 = 0;
  List<HealthData> _healthDataList = [];
  Future<String> _loadHealthData() async {
    

    final response = await http.get(Uri.parse(
        'https://byqa2hsitf.execute-api.us-east-2.amazonaws.com/dev/displayVitalsMobile'));
    
    return response.body;
  }

  Future<void> _parseHealthData() async {
    print("2");
    String jsonString = await _loadHealthData();
    final jsonData = json.decode(jsonString);
    Map<String, dynamic> data = jsonDecode(jsonData['body']);
    audioLevel = data['audio_level'];
    hrv = data['hrv'];
    heartrate = data['heart_rate'];
    spo2 = data['oxygen_saturation'];

    /*
    print(audioLevel);
    List<HealthData> healthDataList = [];
    if (jsonData != null) {
      for (var item in jsonDecode(jsonData['body'])) {
        HealthData healthData = HealthData.fromJson(item);
        healthDataList.add(healthData);
      }
    }
    */
    setState(() {
      //_healthDataList = healthDataList;
    });
  }

  @override
  void initState() {
    super.initState();
    print("1");
    _parseHealthData();

    // Add listener to the scroll controller to detect when user reaches the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list, fetch new data
        _parseHealthData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text('Evidence Report'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioPage(
                                audioUrl:
                                    'https://firebasestorage.googleapis.com/v0/b/watchfull-eye.appspot.com/o/recording.wav?alt=media&token=5b9f8360-635f-458d-b52a-0a05263b9195',
                              )));
                },
              ),
              Divider(
                height: 4,
                thickness: 2,
              ),
              ListTile(
                title: const Text('Managing Users'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyForm()));
                },
              ),
            ],
          ),
        ),
      ),

      // endDrawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       const DrawerHeader(
      //         child: Text(
      //           'Settings',
      //           style: TextStyle(color: Colors.white, fontSize: 25),
      //         ),
      //         decoration: BoxDecoration(
      //           color: Colors.black,
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.assignment,
      //           size: 30,
      //         ),
      //         title: const Text(
      //           'Evidence Report',
      //           style: TextStyle(fontSize: 20),
      //         ),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => EvidenceReport()));
      //         },
      //       ),
      //       const Divider(
      //         thickness: 1,
      //         color: Colors.grey,
      //         height: 20,
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.people,
      //           size: 30,
      //         ),
      //         title: const Text(
      //           'Manage Users',
      //           style: TextStyle(fontSize: 20),
      //         ),
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        // leading: Builder(builder: (BuildContext context) {
        //   return IconButton(onPressed: () {}, icon: Icon(Icons.menu_sharp));
        // }),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _parseHealthData();
            },
            icon: const Icon(
              Icons.refresh_sharp,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          ' Health Data',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GridTile(
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.hearing),
                  const SizedBox(height: 8),
                  const Text(
                    'Noise',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${audioLevel.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          GridTile(
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border),
                  const SizedBox(height: 8),
                  const Text(
                    'HRV',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('${(hrv == 0) ? 0 : hrv.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          GridTile(
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite),
                  const SizedBox(height: 8),
                  const Text(
                    'Heart Rate',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${heartrate.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          GridTile(
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bloodtype,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SpO2',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${spo2.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0, left: 30),
        child: Container(
          height: 50,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: FloatingActionButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AudioPage(
                              audioUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/watchfull-eye.appspot.com/o/file_example_WAV_1MG.wav?alt=media&token=5dc0de2d-7450-4d1b-9e71-22b473c6bb56",
                            )))
              },
              child: const Text(
                "Evidence Reports",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.zero, right: Radius.zero)),
            ),
          ),
        ),
      ),
    );
  }
}
