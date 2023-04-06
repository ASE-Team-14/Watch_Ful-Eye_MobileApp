import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchfull_eye/globals.dart';

import 'manageuser.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.builder(
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemCount: 4,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             color: Colors.red,
//             child: Center(child: Text('$index')),
//           );
//         },
//       ),
//       appBar: AppBar(
//         title: const Text("Watchful Eye"),
//       ),
//     );
//   }
// }
/* Future<String> _loadHealthData() async {
    // Change the URL to your online JSON file
    final response = await http.get(Uri.parse('https://byqa2hsitf.execute-api.us-east-2.amazonaws.com/default/displayVitalsMobile'));
    return response.body;
  }

  Future<void> _parseHealthData() async {
    String jsonString = await _loadHealthData();
    final jsonData = json.decode(jsonString);
    List<HealthData> healthDataList = [];

    for (var item in jsonData['health_data']) {
      HealthData healthData = HealthData.fromJson(item);
      healthDataList.add(healthData);
    }

    setState(() {
      _healthDataList = healthDataList;
    });
  }

  @override
  void initState() {
    super.initState();
    _parseHealthData();
  }
*/

class DisplayField extends StatefulWidget {
  const DisplayField({Key? key}) : super(key: key);

  @override
  State<DisplayField> createState() => _DisplayFieldState();
}

class _DisplayFieldState extends State<DisplayField> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Users'),
        ),
        body: ListView.builder(
          itemCount: manageUserName.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              title: Text(
                manageUserName[index],
              ),
              
              subtitle: Text(manageUserEmail[index]),
            );
          },
        ),
      ),
    );
  }
}
