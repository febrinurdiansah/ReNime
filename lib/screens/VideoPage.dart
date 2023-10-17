import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:http/http.dart' as http;
import '../models/DataAnime.dart';

class VideoPage extends StatefulWidget {
  final String idAnime;
  final int Eps;

  const VideoPage({super.key, required this.idAnime, required this.Eps});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final _meeduPlayerController = MeeduPlayerController(
    controlsStyle: ControlsStyle.primary,
    autoHideControls: true,
    screenManager: ScreenManager(
      forceLandScapeInFullscreen: true,
    ),
    controlsEnabled: true,
    manageWakeLock: true,
    manageBrightness: true,
    excludeFocus: true,
    enabledButtons: EnabledButtons(
      fullscreen: true,
      videoFit: true,
      playBackSpeed: false,
      lockControls: false
    ),
    enabledControls: EnabledControls(
      desktopDoubleTapToFullScreen: true,
      brightnessSwipes: true,
      volumeSwipes: true,
      doubleTapToSeek: true,
      seekSwipes: true,
    ),
  );

  ValueNotifier<Quality?> _quality = ValueNotifier(null);
  Duration _currentPosition = Duration.zero; 
  StreamSubscription? _subscription;
  final List _qualities = videoQualities;
  List<VideoSource> _videoSources = [];

  @override
  void initState() {
    super.initState();
    _quality.value = _qualities[0]; // set the default video quality (360p)
    // listen the video position
    _subscription = _meeduPlayerController.onPositionChanged.listen(
      (Duration position) {
        _currentPosition = position; // save the video position
      },
    );
    WakelockPlus.enable();
    _loadVideoSources(); // Panggil _loadVideoSources() di initState
  }

  Future<Map<String, dynamic>> fetchVideoSources() async {
  final apiUrl = 'https://api.consumet.org/anime/gogoanime/watch/${widget.idAnime}-episode-${widget.Eps}';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load video sources');
  }
}

  Future<void> _loadVideoSources() async {
    // Load video sources from API
    final data = await fetchVideoSources();
    final sources = parseVideoSources(data);
    setState(() {
      _videoSources = sources;
    });
  }

  void _setDataSource() async {
  if (_videoSources.isNotEmpty && _quality.value != null) {
    final source = _videoSources.firstWhere(
      (source) => source.quality == _quality.value!.label,
      orElse: () => _videoSources.first,
    );
    await _meeduPlayerController.setDataSource(
      DataSource(
        type: source.isM3U8 ? DataSourceType.network : DataSourceType.asset,
        source: source.url,
      ),
      autoplay: true,
      seekTo: _currentPosition,
    );
  }
}


  void _onChangeVideoQuality() {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => CupertinoActionSheet(
      actions: List.generate(
        _qualities.length,
        (index) {
          final quality = _qualities[index];
          return CupertinoActionSheetAction(
            child: Text("${quality.label}"),
            onPressed: () {
              _quality.value = quality; // Perbarui kualitas saat ini
              Navigator.pop(_);
              _setDataSource(); // Panggil _setDataSource() setelah memperbarui kualitas
            },
          );
        },
      ),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(_),
        child: Text("Cancel"),
        isDestructiveAction: true,
      ),
    ),
  );
}


  @override
  void dispose() {
    super.dispose();
    _meeduPlayerController.dispose();
    _subscription?.cancel();
    WakelockPlus.disable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: MeeduVideoPlayer(
              controller: _meeduPlayerController,
              bottomRight: (ctx, controller, responsive) {
                // creates a responsive fontSize using the size of video container
                final double fontSize = responsive.ip(3);

                return CupertinoButton(
                  padding: EdgeInsets.all(5),
                  minSize: 25,
                  child: ValueListenableBuilder<Quality?>(
                    valueListenable: this._quality,
                    builder: (context, Quality? quality, child) {
                      return Text(
                        "${quality!.label}",
                        style: TextStyle(
                          fontSize: fontSize > 18 ? 18 : fontSize,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  onPressed: _onChangeVideoQuality,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
