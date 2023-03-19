import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String filePath = '';

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      // Initialize the S3 client
      final credentials = AwsClientCredentials(accessKey: '', secretKey: '');
      final s3 = S3(
        region: 'us-east-1', // replace with your AWS region
        credentials: credentials,
      );
      // Download the audio file from S3
      final response = await s3.getObject(
        bucket: 'storeaudiofiles-watchfuleye', // replace with your bucket name
        key:
            'https://s3.console.aws.amazon.com/s3/object/storeaudiofiles-watchfuleye?region=us-east-2&prefix=recording.wav',
      );
      final audioData = response.body!;
      // Play the downloaded audio file
      final _audioPlayer = AudioPlayer();
      _audioPlayer.play(AssetSource(
          'https://firebasestorage.googleapis.com/v0/b/watchfull-eye.appspot.com/o/recording.wav?alt=media&token=5b9f8360-635f-458d-b52a-0a05263b9195'));
      setState(() => _isLoading = false);
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Player')),
      body: Center(
          child: ElevatedButton(
              child: Text("PRESS"), onPressed: () => _loadAudio())),
    );
  }
}
