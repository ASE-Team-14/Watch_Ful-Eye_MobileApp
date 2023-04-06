import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watchfull_eye/datadisplay.dart';

import 'package:watchfull_eye/manageuser.dart';
import 'package:watchfull_eye/testingaws.dart';

import 'modalclass.dart';
import 'package:http/http.dart' as http;

class WatchDataFrench extends StatefulWidget {
  @override
  _WatchDataFrenchState createState() => _WatchDataFrenchState();
}

class _WatchDataFrenchState extends State<WatchDataFrench> {
  ScrollController _scrollController = ScrollController();
  late Color tileColor;
  late Timer timer;
  bool showWarning = false;
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

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print("1");
    _parseHealthData();
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
                  color: Colors.grey,
                ),
                child: Text(
                  'Paramètres',
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
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              ListTile(
                title: const Text('Rapport de preuve'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => S3AudioList()));
                },
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              ListTile(
                title: const Text('Gestion des utilisateurs'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyForm()));
                },
              ),
              const Divider(
                height: 4,
                thickness: 2,
              ),
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WatchData()));
                },
              ),
            ],
          ),
        ),
      ),
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
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        title: const Text(
          ' Données de santé',
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
                shadowColor: Colors.purpleAccent,
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.hearing),
                    const SizedBox(height: 8),
                    const Text(
                      'Bruit',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${audioLevel.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            GridTile(
              child: Card(
                shadowColor: Colors.purpleAccent,
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite_border),
                    const SizedBox(height: 8),
                    const Text(
                      'VRC',
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
                shadowColor: Colors.purpleAccent,
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.only(left: 60.0),
                      child: Text(
                        'Rythme Cardiaque',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
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
                shadowColor: Colors.purpleAccent,
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
                  " Rapport de preuve",
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
