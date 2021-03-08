import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef BlurViewWidgetCreatedCallback = void Function(
    BlurViewWidgetController controller);

class BlurViewWidget extends StatefulWidget {
  const BlurViewWidget({
    Key key,
    this.onBlurViewWidgetCreated,
  }) : super(key: key);

  final BlurViewWidgetCreatedCallback onBlurViewWidgetCreated;

  @override
  State<StatefulWidget> createState() => _BlurViewWidgetState();
}

class _BlurViewWidgetState extends State<BlurViewWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      print('creating platform view for android');
      return AndroidView(
        viewType: 'plugins/instagram_cropper',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
      );
    }
    return const Text('iOS platform version is not implemented yet.');
  }

  void _onPlatformViewCreated(int id) {
    print('creating platform view created');
    if (widget.onBlurViewWidgetCreated == null) {
      return;
    }
    widget.onBlurViewWidgetCreated(BlurViewWidgetController._(id));
  }
}

class BlurViewWidgetController {
  BlurViewWidgetController._(int id)
      : _channel = MethodChannel('plugins/instagram_cropper_$id');

  final MethodChannel _channel;

  Future<void> getView() async {
    return await _channel.invokeMethod('getView');
  }

  Future<void> setUri(String value) async {
    print('settings setUri');

    return await _channel.invokeMethod('setUri', value);
  }
}
