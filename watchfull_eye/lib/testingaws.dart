import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watchfull_eye/evidence.dart';

class S3AudioList extends StatefulWidget {
  @override
  _S3AudioListState createState() => _S3AudioListState();
}

class _S3AudioListState extends State<S3AudioList> {
  List<String> _audioFiles = [];

  @override
  void initState() {
    super.initState();
    _getAudioFilesFromS3();
  }

  Future<void> _getAudioFilesFromS3() async {
    const s3Url = 'https://storeaudiofiles-watchfuleye.s3.amazonaws.com';
    final response = await http.get(Uri.parse(s3Url));
    final xmlString = response.body;
    final items = xmlString.split('</Key>');
    final List<String> files = [];
    items.forEach((element) {
      if (element.contains('<Key>')) {
        final String file = element.split('<Key>')[1];
        if (file.endsWith('.wav')) {
          files.add(file);
        }
      }
    });

    setState(() {
      _audioFiles = files;
    });
  }

  Future<void> _downloadFile(String fileUrl, String fileName) async {
    final response = await http.get(Uri.parse(fileUrl));

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    await file.writeAsBytes(response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio History'),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: _audioFiles.length,
        itemBuilder: (context, index) {
          final fileName = _audioFiles[index];
          final regExp = RegExp(r'(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})');
          final match = regExp.firstMatch(fileName);
          final year = int.parse(match?.group(1) ?? "0");
          final month = int.parse(match?.group(2) ?? "0");
          final day = int.parse(match?.group(3) ?? "0");
          final hour = int.parse(match?.group(4) ?? "0");
          final minute = int.parse(match?.group(5) ?? "0");
          final second = int.parse(match?.group(6) ?? "0");
          final dateTime = DateTime(year, month, day, hour, minute, second);
          final formattedDateTime =
              DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);

          return ListTile(
            trailing: IconButton(
              onPressed: () async {
                final fileUrl =
                    'https://storeaudiofiles-watchfuleye.s3.amazonaws.com/$fileName';
                print(fileUrl);
                await _downloadFile(fileUrl, fileName ?? "");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AudioPage(audioUrl: fileUrl)));
              },
              icon: const Icon(
                Icons.play_circle_fill,
                size: 30,
                color: Colors.lightGreen,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(color: Colors.cyan, width: 1.0),
            ),
            title: Text(
              'Recording ${index + 1}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(formattedDateTime),
            onTap: () async {
              final fileUrl =
                  'https://storeaudiofiles-watchfuleye.s3.amazonaws.com/$fileName';
              print(fileUrl);
              await _downloadFile(fileUrl, fileName ?? "");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AudioPage(audioUrl: fileUrl)));
            },
          );
        },
      ),
    );
  }
}
