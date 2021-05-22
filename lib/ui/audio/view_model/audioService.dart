import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:just_audio/just_audio.dart';

MediaControl playControl = MediaControl(
  androidIcon: 'drawable/ic_action_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
MediaControl pauseControl = MediaControl(
  androidIcon: 'drawable/ic_action_pause',
  label: 'Pause',
  action: MediaAction.pause,
);
MediaControl skipToNextControl = MediaControl(
  androidIcon: 'drawable/ic_action_skip_next',
  label: 'Next',
  action: MediaAction.skipToNext,
);
MediaControl skipToPreviousControl = MediaControl(
  androidIcon: 'drawable/ic_action_skip_previous',
  label: 'Previous',
  action: MediaAction.skipToPrevious,
);
MediaControl stopControl = MediaControl(
  androidIcon: 'drawable/ic_action_stop',
  label: 'Stop',
  action: MediaAction.stop,
);

class AudioPlayerTask extends BackgroundAudioTask {
  AudioPlayer _audioPlayer = new AudioPlayer();
  AudioProcessingState _skipState;

  StreamSubscription<ProcessingState> _playerStateSubscription;
  StreamSubscription<PlaybackEvent> _eventSubscription;
  // StreamSubscription<PlayerState> _eventSubscription;

  List<MediaItem> _queue = [];
  List<MediaItem> get queue => _queue;

  int get index => _audioPlayer.playbackEvent.currentIndex;
  MediaItem get mediaItem => index == null ? null : queue[index];
  //

  int _queueIndex = 0;

  bool _playing;

  bool get hasNext => _queueIndex + 1 < _queue.length;

  bool get hasPrevious => _queueIndex > 0;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    _loadMediaItemsIntoQueue(params);

    _propogateEventsFromAudioPlayerToAudioServiceClients();
    _performSpecialProcessingForStateTransistions();
    _loadQueue();
    // onSkipToNext();
  }

  @override
  Future<void> onPlay() async {
    if (_skipState == null) {
      _playing = true;
      _audioPlayer.play();
    }
  }

  @override
  Future<void> onPause() async {
    _playing = false;
    _audioPlayer.pause();
    // _audioPlayer.dispose();
  }

  @override
  Future<void> onFastForward() => _seekRelative(fastForwardInterval);

  @override
  Future<void> onRewind() => _seekRelative(-rewindInterval);


  @override
  Future<void> onSkipToNext() async {
    skip(1);
  }

  @override
  Future<void> onSkipToPrevious() async {
    skip(-1);
  }

  void skip(int offset) async {
  
    int newPos = _queueIndex + offset;
    if ((newPos >= 0 && newPos < _queue.length)) {
      print('$newPos true');
      return;
    }
    if (null == _playing) {
      _playing = true;
    } else if (_playing) {
      await _audioPlayer.stop();
    }
    _queueIndex = newPos;
    _skipState = offset > 0
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
        print('Skippingggggggggggggg to ' + mediaItem.id);
    AudioServiceBackground.setMediaItem(mediaItem);
    print('Skippingggggggggggggg to ' + mediaItem.id);
    await _audioPlayer.setUrl(mediaItem.id);
    print('Skippingggggggggggggg to ' + mediaItem.id);
    print(mediaItem.id);
    _skipState = null;
    if (_playing) {
      onPlay();
    } else {
      _setState(processingState: AudioProcessingState.ready);
    }
  }

  @override
  Future<void> onStop() async {
    _playing = false;
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    _playerStateSubscription.cancel();
    _eventSubscription.cancel();
    return await super.onStop();
  }

  @override
  Future<void> onSeekTo(Duration position) async {
    _audioPlayer.seek(position);
  }

  @override
  Future<void> onClick(MediaButton button) async {
    playPause();
  }

  // @override
  // Future<void> onFastForward() async {
  //   await _seekRelative(fastForwardInterval);
  // }

  // @override
  // Future<void> onRewind() async {
  //   await _seekRelative(rewindInterval);
  // }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    
    final newIndex = queue.indexWhere((item) => item.id == mediaId);
    print('This is the new Index: ' + newIndex.toString());
    print('This is the old Index: ' + index.toString());
    if (newIndex == -1) return;
    _skipState = newIndex > index
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    _audioPlayer.seek(Duration.zero, index: newIndex);
  }

  Future<void> _seekRelative(Duration offset) async {
    var newPosition = _audioPlayer.position + offset;
    if (newPosition < Duration.zero) {
      newPosition = Duration.zero;
    }
    if (newPosition > mediaItem.duration) {
      newPosition = mediaItem.duration;
    }
    await _audioPlayer.seek(_audioPlayer.position + offset);
  }

  _handlePlaybackCompleted() {
    if (hasNext) {
      onSkipToNext();
    } else {
      onStop();
    }
  }

  void playPause() {
    if (AudioServiceBackground.state.playing)
      onPause();
    else
      onPlay();
  }

  Future<void> _setState({
    AudioProcessingState processingState,
    Duration position,
    Duration bufferedPosition,
  }) async {
    print('SetState $processingState');
    if (position == null) {
      position = _audioPlayer.position;
    }
    await AudioServiceBackground.setState(
      controls: getControls(),
      systemActions: [MediaAction.seekTo],
      processingState:
          processingState ?? AudioServiceBackground.state.processingState,
      playing: _playing,
      position: position,
      bufferedPosition: bufferedPosition ?? position,
      speed: _audioPlayer.speed,
    );
  }

  List<MediaControl> getControls() {
    if (_playing) {
      return [
        skipToPreviousControl,
        pauseControl,
        stopControl,
        skipToNextControl
      ];
    } else {
      return [
        skipToPreviousControl,
        playControl,
        stopControl,
        skipToNextControl
      ];
    }
  }

  void _loadMediaItemsIntoQueue(Map<String, dynamic> params) {
    print('Running loadMediaItmes');
    _queue.clear();
    final List mediaItems = params['data'];
    for (var item in mediaItems) {
      final mediaItem = MediaItem.fromJson(item);
      _queue.add(mediaItem);
    }
    print('printing queue');
  }

  void _propogateEventsFromAudioPlayerToAudioServiceClients() {
    _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
      _broadcastState();
    });
  }

  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      androidCompactActions: [0, 1, 2],
      processingState: _getProcessingState(),
      playing: _audioPlayer.playing,
      position: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
    );
  }

  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState;
    switch (_audioPlayer.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_audioPlayer.processingState}");
    }
  }

  void _performSpecialProcessingForStateTransistions() {
    _audioPlayer.processingStateStream
        .where((state) => state == ProcessingState.completed)
        .listen((state) {
      _handlePlaybackCompleted();
    });
  }

  Future<void> _loadQueue() async {
    AudioServiceBackground.setQueue(queue);
    try {
      await _audioPlayer.setAudioSource(ConcatenatingAudioSource(
        children:
            queue.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
      ));
      _audioPlayer.durationStream.listen((duration) {
        _updateQueueWithCurrentDuration(duration);
      });
      onPlay();
    } catch (e) {
      print('Error: $e');
      onStop();
    }
  }

  void _updateQueueWithCurrentDuration(Duration duration) {
    final songIndex = _audioPlayer.playbackEvent.currentIndex;
    print('current index: $songIndex, duration: $duration');
    final modifiedMediaItem = mediaItem.copyWith(duration: duration);
    _queue[songIndex] = modifiedMediaItem;
    AudioServiceBackground.setMediaItem(_queue[songIndex]);
    AudioServiceBackground.setQueue(_queue);
  }
}

class AudioState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  const AudioState(this.queue, this.mediaItem, this.playbackState);
}

class AudioState2 {
  const AudioState2(this.currentTime, this.totalTime);
  final Duration currentTime;
  final Duration totalTime;

  const AudioState2.initial() : this(Duration.zero, Duration.zero);
}



void audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}




// class AudioPlayerTask extends BackgroundAudioTask {
//   AudioPlayer _player = new AudioPlayer();
//   AudioProcessingState _skipState;
//   StreamSubscription<PlaybackEvent> _eventSubscription;

//   List<MediaItem> _queue = [];
//   List<MediaItem> get queue => _queue;

//   int get index => _player.playbackEvent.currentIndex;
//   MediaItem get mediaItem => index == null ? null : queue[index];

//   @override
//   Future<void> onStart(Map<String, dynamic> params) async {
//     _loadMediaItemsIntoQueue(params);
//     await _setAudioSession();
//     _propogateEventsFromAudioPlayerToAudioServiceClients();
//     _performSpecialProcessingForStateTransistions();
//     _loadQueue();
//   }

//   void _loadMediaItemsIntoQueue(Map<String, dynamic> params) {
//     _queue.clear();
//     final List mediaItems = params['data'];
//     for (var item in mediaItems) {
//       final mediaItem = MediaItem.fromJson(item);
//       _queue.add(mediaItem);
//     }
//   }

//   Future<void> _setAudioSession() async {
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration.music());
//   }

//   void _propogateEventsFromAudioPlayerToAudioServiceClients() {
//     _eventSubscription = _player.playbackEventStream.listen((event) {
//       _broadcastState();
//     });
//   }

//   void _performSpecialProcessingForStateTransistions() {
//     _player.processingStateStream.listen((state) {
//       switch (state) {
//         case ProcessingState.completed:
//           onStop();
//           break;
//         case ProcessingState.ready:
//           _skipState = null;
//           break;
//         default:
//           break;
//       }
//     });
//   }

//   Future<void> _loadQueue() async {
//     AudioServiceBackground.setQueue(queue);
//     try {
//       await _player.load(ConcatenatingAudioSource(
//         children:
//             queue.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
//       ));
//       _player.durationStream.listen((duration) {
//         _updateQueueWithCurrentDuration(duration);
//       });
//       onPlay();
//     } catch (e) {
//       print('Error: $e');
//       onStop();
//     }
//   }

//   void _updateQueueWithCurrentDuration(Duration duration) {
//     final songIndex = _player.playbackEvent.currentIndex;
//     print('current index: $songIndex, duration: $duration');
//     final modifiedMediaItem = mediaItem.copyWith(duration: duration);
//     _queue[songIndex] = modifiedMediaItem;
//     AudioServiceBackground.setMediaItem(_queue[songIndex]);
//     AudioServiceBackground.setQueue(_queue);
//   }

//   @override
//   Future<void> onSkipToQueueItem(String mediaId) async {
//     final newIndex = queue.indexWhere((item) => item.id == mediaId);
//     if (newIndex == -1) return;
//     _skipState = newIndex > index
//         ? AudioProcessingState.skippingToNext
//         : AudioProcessingState.skippingToPrevious;
//     _player.seek(Duration.zero, index: newIndex);
//   }

//   @override
//   Future<void> onPlay() => _player.play();

//   @override
//   Future<void> onPause() => _player.pause();

//   @override
//   Future<void> onSeekTo(Duration position) => _player.seek(position);

//   @override
//   Future<void> onFastForward() => _seekRelative(fastForwardInterval);

//   @override
//   Future<void> onRewind() => _seekRelative(-rewindInterval);

//   @override
//   Future<void> onStop() async {
//     await _player.dispose();
//     _eventSubscription.cancel();
//     await _broadcastState();
//     await super.onStop();
//   }

//   /// Jumps away from the current position by [offset].
//   Future<void> _seekRelative(Duration offset) async {
//     var newPosition = _player.position + offset;
//     if (newPosition < Duration.zero) newPosition = Duration.zero;
//     if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
//     await _player.seek(newPosition);
//   }

//   /// Broadcasts the current state to all clients.
//   Future<void> _broadcastState() async {
//     await AudioServiceBackground.setState(
//       controls: [
//         MediaControl.skipToPrevious,
//         if (_player.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.skipToNext,
//       ],
//       androidCompactActions: [0, 1, 2],
//       processingState: _getProcessingState(),
//       playing: _player.playing,
//       position: _player.position,
//       bufferedPosition: _player.bufferedPosition,
//       speed: _player.speed,
//     );
//   }

//   /// Maps just_audio's processing state into into audio_service's playing
//   /// state. If we are in the middle of a skip, we use [_skipState] instead.
//   AudioProcessingState _getProcessingState() {
//     if (_skipState != null) return _skipState;
//     switch (_player.processingState) {
//       case ProcessingState.none:
//         return AudioProcessingState.stopped;
//       case ProcessingState.loading:
//         return AudioProcessingState.connecting;
//       case ProcessingState.buffering:
//         return AudioProcessingState.buffering;
//       case ProcessingState.ready:
//         return AudioProcessingState.ready;
//       case ProcessingState.completed:
//         return AudioProcessingState.completed;
//       default:
//         throw Exception("Invalid state: ${_player.processingState}");
//     }
//   }
// }
