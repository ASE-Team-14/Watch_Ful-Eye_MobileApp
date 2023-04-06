import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchfull_eye/datadisplayfrench.dart';

import 'package:watchfull_eye/manageuser.dart';
import 'package:watchfull_eye/testingaws.dart';

import 'modalclass.dart';
import 'package:http/http.dart' as http;

late String code = List.generate(4, (index) => Random().nextInt(10)).join();

class WatchData extends StatefulWidget {
  @override
  _WatchDataState createState() => _WatchDataState();
}

class _WatchDataState extends State<WatchData> {
  String? _selectedOption;
  late Color tileColor;
  late Timer timer;
  bool showWarning = false;

  ScrollController _scrollController = ScrollController();
  double audioLevel = 0.0;
  double hrv = 0.0;
  double heartrate = 0;
  double spo2 = 0;
  List<HealthData> _healthDataList = [];
  late String code = List.generate(4, (index) => Random().nextInt(10)).join();
  Future<String> _loadHealthData() async {
    final response = await http.get(Uri.parse(
        'https://byqa2hsitf.execute-api.us-east-2.amazonaws.com/dev/displayVitalsMobile'));

    return response.body;
  }

  Future<String> generateAndStoreCode() async {
    try {
      final headers = {'Content-Type': 'application/json'};

      // Create the request body
      final body = json.encode({'code': code});

      // Send the POST request to the API endpoint
      const url =
          'https://aax5u0nfg0.execute-api.us-east-2.amazonaws.com/dev/storecode';
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      // Check if the code was successfully stored
      if (response.statusCode == 200) {
        // Return the code if it was stored successfully
        return code;
      } else {
        // Handle the error if the code was not stored successfully
        throw Exception('Failed to store code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any other errors that may have occurred

      throw Exception('Failed to generate and store code');
    }
  }

  Future<void> _parseHealthData() async {
    String jsonString = await _loadHealthData();
    final jsonData = json.decode(jsonString);
    Map<String, dynamic> data = jsonDecode(jsonData['body']);
    audioLevel = data['audio_level'];
    hrv = data['hrv'];
    heartrate = data['heart_rate'];
    spo2 = data['oxygen_saturation'];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _parseHealthData();
    generateAndStoreCode();
    tileColor = Colors.red;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        tileColor = (tileColor == Colors.red) ? Colors.white : Colors.red;
        if (heartrate >= 100) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Heart rate is high",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 10,
              fontSize: 16.0);
        } else if (heartrate == 0) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Heart rate is low",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (audioLevel >= 100) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Audio level is high",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
              timeInSecForIosWeb: 4);
        } else if (hrv >= 100) {
          showWarning = true;
          Fluttertoast.showToast(
            msg: "HRV is high",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (spo2 <= 94) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "SpO2 is low",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (audioLevel >= 100 && hrv >= 100) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Audio level and HRV are high",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (audioLevel >= 100 && heartrate >= 100) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Audio level and heartrate are high",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (audioLevel >= 100 && spo2 <= 94) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Audio level is high and SpO2 is less",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (hrv >= 100 && spo2 <= 94) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "HRV is high and SpO2 is low",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (heartrate >= 100 && hrv >= 100) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Heart Rate and HRV are high",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (heartrate >= 100 && spo2 <= 94) {
          showWarning = true;
          Fluttertoast.showToast(
              msg: "Heart rate is high and SpO2 is low",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
              timeInSecForIosWeb: 4);
        }
      });
    });

    @override
    void dispose() {
      timer.cancel();
      super.dispose();
    }

    // Add listener to the scroll controller to detect when user reaches the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list, fetch new data
        _parseHealthData();
      }
    });
  }

  Future<void> _loadSelectedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedOption = prefs.getString('selectedOption');
    });
  }

  Future<void> _saveSelectedOption(String option) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedOption', option);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 100.0),
                  child: Text(
                    code,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              ListTile(
                title: const Text(
                  'Evidence Report',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => S3AudioList()));
                },
                selected: _selectedOption == 'Evidence Report',
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              ListTile(
                title: const Text(
                  'Managing Users',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyForm()));
                },
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              ListTile(
                title: const Text(
                  'Francias',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WatchDataFrench()));
                },
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
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
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        title: const Text(
          ' Health Data',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GridTile(
              child: Card(
                elevation: 20,
                color: (audioLevel >= 100) ? tileColor : Colors.white,
                shadowColor: Colors.purpleAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.hearing),
                    const SizedBox(height: 8),
                    const Text(
                      'Noise',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                elevation: 20,
                color: (hrv >= 100) ? tileColor : Colors.white,
                shadowColor: Colors.purpleAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite_border),
                    const SizedBox(height: 8),
                    const Text(
                      'HRV',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                elevation: 20,
                color: (heartrate >= 100) ? tileColor : Colors.white,
                shadowColor: (heartrate >= 100)
                    ? Color.fromARGB(255, 252, 25, 9)
                    : Colors.purpleAccent[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite),
                    const SizedBox(height: 8),
                    const Text(
                      'Heart Rate',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${heartrate.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridTile(
              child: Card(
                elevation: 20,
                color: (spo2 <= 94) ? tileColor : Colors.white,
                shadowColor: Colors.purpleAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bloodtype,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'SpO2',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0, left: 30),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: Container(
            height: 50,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: FloatingActionButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => S3AudioList()))
                },
                child: const Text(
                  "Evidence Reports",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.lightGreen[700],
                foregroundColor: Colors.white,
                elevation: 5,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.zero, right: Radius.zero)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
