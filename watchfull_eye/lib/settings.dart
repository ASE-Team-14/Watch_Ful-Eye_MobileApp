import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  void _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'en';
    });
  }

  void _saveLanguagePreference(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _saveLanguagePreference('en'),
            child: Text('English'),
            style: ButtonStyle(
              backgroundColor: _selectedLanguage == 'en' ? MaterialStateProperty.all(Colors.blue) : null,
            ),
          ),
          ElevatedButton(
            onPressed: () => _saveLanguagePreference('fr'),
            child: Text('Français'),
            style: ButtonStyle(
              backgroundColor: _selectedLanguage == 'fr' ? MaterialStateProperty.all(Colors.blue) : null,
            ),
          ),
        ],
      ),
    );
  }
}
