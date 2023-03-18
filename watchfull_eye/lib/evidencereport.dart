import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:audioplayers/audioplayers.dart';
class AudioPlayerScreen extends StatefulWidget {
  final String filePath;
  AudioPlayerScreen({required this.filePath});
  @override  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}
class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isLoading = true;
  @override  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadAudio();
  }
  Future<void> _loadAudio() async {
    try {
      // Initialize the S3 client      
      // final credentials = AwsClientCredentials(accessKey: 'your_access_key', secretKey: 'your_secret_key');
      final s3 = S3(
        region: 'us-west-2', // replace with your AWS region        
        // credentials: credentials,
      );
      // Download the audio file from S3      
      final response = await s3.getObject(
        bucket: 'storeaudiofiles-watchfuleye',// replace with your bucket name        
        key: widget.filePath,
      );
      final downloadUrl = Uri.dataFromBytes(response.body!.toList()).toString();
      // Play the downloaded audio file     
      await _audioPlayer.play(downloadUrl as Source);
      setState(() => _isLoading = false);
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
    }
  }
  @override  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Player')),
      body: Center(
        child: _isLoading ? CircularProgressIndicator() : Text('Audio is playing...'),
      ),
    );
  }
}