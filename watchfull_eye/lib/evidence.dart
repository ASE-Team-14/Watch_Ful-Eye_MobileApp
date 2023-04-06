import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:just_audio/just_audio.dart';

class AudioPage extends StatefulWidget {
  final String audioUrl;

  AudioPage({required this.audioUrl});

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _player.setUrl(widget.audioUrl);
      _player.playerStateStream.listen((state) {
        if (state.playing != _isPlaying) {
          setState(() {
            _isPlaying = state.playing;
          });
        }
      });
    } catch (e) {
      print('Error initializing player: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.green,
              ),
              onPressed: () async {
                if (_isPlaying) {
                  await _player.pause();
                } else {
                  await _player.play();
                }
              },
            ),
            SizedBox(height: 16),
            Text('Tap the button to play/pause audio'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _audioUrls = [];

  @override
  void initState() {
    super.initState();

    _getAudioUrls();
  }

  Future<void> _getAudioUrls() async {
    try {
      ListResult result = await FirebaseStorage.instance.ref().listAll();
      List<String> urls = await Future.wait(
        result.items.map((ref) => ref.getDownloadURL()),
      );
      setState(() {
        _audioUrls = urls;
      });
    } catch (e) {
      print('Error getting audio URLs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evidence'),
        backgroundColor: Colors.purpleAccent[200],
      ),
      body: _audioUrls.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _audioUrls.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  'Recording ${index + 1}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AudioPage(audioUrl: _audioUrls[index]),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
