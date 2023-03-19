// import 'package:flutter/material.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:just_audio/just_audio.dart';
// import 'amplifyconfiguration.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';

// Future<void> configureAmplify() async {
//   try {
//     await Amplify.addPlugins([AmplifyStorageS3()]);
//     await Amplify.configure(amplifyconfig);
//     print('Amplify configured');
//   } catch (e) {
//     print('Error configuring Amplify: $e');
//   }
// }

// class AudioListPage extends StatefulWidget {
//   @override
//   _AudioListPageState createState() => _AudioListPageState();
// }

// class _AudioListPageState extends State<AudioListPage> {
//   List<AudioFile> _audioFiles = [];
//   @override
//   void initState() {
//     super.initState();
//     listAudioFiles().then((files) => setState(() => _audioFiles = files));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Audio Files')),
//       body: ListView.builder(
//         itemCount: _audioFiles.length,
//         itemBuilder: (context, index) {
//           AudioFile file = _audioFiles[index];
//           return ListTile(
//             title: Text(file.key),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => AudioPlayerPage(file: file)),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<List<AudioFile>> listAudioFiles() async {
//     try {
//       ListResult result = await Amplify.Storage.list(
//           path:
//               'https://storeaudiofiles-watchfuleye.s3.us-east-2.amazonaws.com/recording.wav',
//           options: S3ListOptions());
//       List<AudioFile> audioFiles = [];
//       if (result.items != null) {
//         audioFiles = await Future.wait(result.items.map((item) async =>
//             AudioFile(
//                 key: item.key,
//                 url: (await Amplify.Storage.getUrl(key: item.key)).url)));
//       }
//       print(audioFiles);
//       return audioFiles;
//     } catch (e) {
//       print('Error listing files: $e');
//       return [];
//     }
//   }
// }

// class AudioPlayerPage extends StatefulWidget {
//   final AudioFile file;
//   AudioPlayerPage({required this.file});
//   @override
//   _AudioPlayerPageState createState() => _AudioPlayerPageState();
// }

// class _AudioPlayerPageState extends State<AudioPlayerPage> {
//   late AudioPlayer _player;
//   @override
//   void initState() {
//     super.initState();
//     _player = AudioPlayer();
//     _player.setUrl(widget.file.url);
//     _player.play();
//   }

//   @override
//   void dispose() {
//     _player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.file.key)),
//       body: Center(
//         child: Text('Now Playing: ${widget.file.key}'),
//       ),
//     );
//   }
// }

// class AudioFile {
//   String key;
//   String url;
//   AudioFile({required this.key, required this.url});
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Play Audio'),
          onPressed: () async {
            try {
              String audioUrl = await FirebaseStorage.instance
                  .ref(
                      'https://firebasestorage.googleapis.com/v0/b/watchfull-eye.appspot.com/o/file_example_WAV_1MG.wav?alt=media&token=5dc0de2d-7450-4d1b-9e71-22b473c6bb56')
                  .getDownloadURL();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioPage(audioUrl: audioUrl),
                ),
              );
            } catch (e) {
              print('Error getting audio URL: $e');
            }
          },
        ),
      ),
    );
  }
}
