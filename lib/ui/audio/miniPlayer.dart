import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:jals/ui/audio/view_model/audioService.dart';
import 'package:jals/widgets/image.dart';
import 'package:rxdart/rxdart.dart';

class MiniPlayerWidget extends StatelessWidget {
  // setAnimation() async {
  //   await Future.delayed(
  //     Duration(seconds: 4),
  //   );
  //   Timer.periodic(Duration(seconds: 2), (timer) {
  //     setState(() {
  //       if (playing) green = !green;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AudioState>(
      stream: _audioStateStream,
      builder: (context, snapshot) {
        final AudioState audioState = snapshot.data;
        final PlaybackState playbackState = audioState?.playbackState;
        final bool playing = playbackState?.playing ?? false;
        final bool completed =
            playbackState?.processingState == AudioProcessingState.completed;
        print(playing);
        print(completed);
        return AudioService.currentMediaItem == null
            ? SizedBox()
            : AnimatedContainer(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // !green ? kGreen : Color(0xff4E3FCE),
                      // !green ? kGreen : kPrimaryColor,
                      // kGreen,
                      // green ? kGreen : Color(0xff4E3FCE),
                      Colors.black,
                      // Colors.pinkAccent
                      Colors.blue,
                      // kGreen,
                      // green ? kGreen : Color(0xff4E3FCE),
                    ],
                  ),
                ),
                duration: Duration(seconds: 1),
                child: SizedBox(
                  height: 61,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1,
                        child: SliderTheme(
                          child: Slider(
                            value: 12,
                            max: 100,
                            onChanged: null,
                          ),
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.orange,
                            inactiveTrackColor: Colors.red.withOpacity(0.3),
                            trackShape: SpotifyMiniPlayerTrackShape(),
                            trackHeight: 2,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 0,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 8,
                            child: GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => ()));
                              // },
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      child: ShowNetworkImage(
                                          imageUrl: AudioService
                                              .currentMediaItem.artUri),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            "${AudioService.currentMediaItem.title}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            "${AudioService.currentMediaItem.artist}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: PlayPauseButton(
                                  height: 40,
                                  width: 40,
                                  pauseIcon: Icons.pause,
                                  playIcon: Icons.play_arrow,
                                  playing: playing,
                                  completed: completed,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
    (queue, mediaItem, playbackState) => AudioState(
      queue,
      mediaItem,
      playbackState,
    ),
  );
}

class PlayPauseButton extends StatelessWidget {
  final double height;
  final double width;
  final IconData pauseIcon;
  final IconData playIcon;
  final bool playing;
  final bool completed;

  PlayPauseButton({
    this.height,
    this.width,
    this.pauseIcon,
    this.playIcon,
    this.playing,
    this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          print("playing is $playing");
          print("completed is $completed");
          return !playing || completed
              ? IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  iconSize: height,
                  onPressed: AudioService.play,
                )
              : IconButton(
                  icon: Icon(
                    Icons.pause,
                    color: Colors.white,
                  ),
                  iconSize: height,
                  onPressed: AudioService.pause,
                );
        });
  }
}

class SpotifyMiniPlayerTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
