import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:watchfull_eye/manageuser.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late List<User> _users = List.empty();

  Future<void> _loadUserListData() async {
    final response = await http.get(Uri.parse(
        'https://2m3gb5nrg7.execute-api.us-east-2.amazonaws.com/dev/displayuserdata'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final userList = jsonDecode(responseData['body']) as List<dynamic>;

      _users = userList.map((json) => User.fromJson(json)).toList();
      print(userList);
    } else {
      throw Exception('Failed to load user list');
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadUserListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('User List'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.user_name),
            subtitle: Text(user.mobile_number),
          );
        },
      ),
    );
  }
}

class User {
  late String user_name;
  late String mobile_number;

  User({required this.user_name, required this.mobile_number});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_name: json['user_name'].toString(),
      mobile_number: json['mobile_number'].toString(),
    );
  }
}
