import 'package:flutter/material.dart';

class MusicControlBar extends StatefulWidget {
  final bool isPlaying;
  final Function onShuffle;
  final Function onPrevious;
  final Function onPlayPause;
  final Function onNext;
  final Function onRepeat;

  const MusicControlBar({
    Key? key,
    required this.isPlaying,
    required this.onShuffle,
    required this.onPrevious,
    required this.onPlayPause,
    required this.onNext,
    required this.onRepeat,
  }) : super(key: key);

  @override
  _MusicControlBarState createState() => _MusicControlBarState();
}

class _MusicControlBarState extends State<MusicControlBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.shuffle, color: Colors.white),
          onPressed: () => widget.onShuffle(),
        ),
        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white),
          onPressed: () => widget.onPrevious(),
        ),
        IconButton(
          icon: Icon(
            widget.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 48.0,
            color: Colors.blue,
          ),
          onPressed: () => widget.onPlayPause(),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white),
          onPressed: () => widget.onNext(),
        ),
        IconButton(
          icon: const Icon(Icons.repeat, color: Colors.white),
          onPressed: () => widget.onRepeat(),
        ),
      ],
    );
  }
}
