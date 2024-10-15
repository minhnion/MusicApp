import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/album.dart';
import 'music_control_bar.dart';

class DetailPage extends StatefulWidget {
  final Album album;
  final List<Album> albumList;  // Thêm danh sách album
  final int currentIndex;       // Thêm chỉ mục hiện tại

  const DetailPage({required this.album, required this.albumList, required this.currentIndex});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isRepeating = false; // Quản lý trạng thái lặp lại
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        currentPosition = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (isRepeating) {
        playMusic(widget.albumList[currentIndex].source!); // Phát lại bài hát hiện tại nếu đang bật chế độ lặp lại
      } else {
        setState(() {
          currentPosition = Duration.zero;
          isPlaying = false;
        });
      }
    });
  }

  Future<void> playMusic(String source) async {
    await _audioPlayer.play(UrlSource(source));
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> pauseMusic() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void playPreviousSong() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      playMusic(widget.albumList[currentIndex].source!);
    }
  }

  void playNextSong() {
    if (currentIndex < widget.albumList.length - 1) {
      setState(() {
        currentIndex++;
      });
      playMusic(widget.albumList[currentIndex].source!);
    } else {
      setState(() {
        currentIndex = 0;
      });
      playMusic(widget.albumList[currentIndex].source!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentAlbum = widget.albumList[currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ClipOval(
              child: Image.network(
                currentAlbum.image!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                currentAlbum.title!,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                currentAlbum.artist!,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Slider(
              value: currentPosition.inSeconds.toDouble(),
              min: 0.0,
              max: totalDuration.inSeconds.toDouble(),
              onChanged: (double value) async {
                await _audioPlayer.seek(Duration(seconds: value.toInt()));
                setState(() {
                  currentPosition = Duration(seconds: value.toInt());
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(currentPosition),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  _formatDuration(totalDuration),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            MusicControlBar(
              isPlaying: isPlaying,
              onShuffle: () {
                // Xử lý khi nhấn nút shuffle
              },
              onPrevious: () {
                playPreviousSong(); // Xử lý phát lại bài hát trước
              },
              onPlayPause: () {
                if (isPlaying) {
                  pauseMusic();
                } else {
                  playMusic(currentAlbum.source!);
                }
              },
              onNext: () {
                playNextSong(); // Xử lý phát bài hát tiếp theo
              },
              onRepeat: () {
                setState(() {
                  isRepeating = !isRepeating; // Bật/Tắt chế độ lặp lại
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

