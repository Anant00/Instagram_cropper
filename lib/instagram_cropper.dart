import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef InstaCropViewCreatedCallback = void Function(
    InstaCropViewController controller);

class BlurViewWidget extends StatefulWidget {
  const BlurViewWidget({
    Key key,
    this.onBlurViewWidgetCreated,
  }) : super(key: key);

  final InstaCropViewCreatedCallback onBlurViewWidgetCreated;

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
    if (widget.onBlurViewWidgetCreated == null) {
      return;
    }
    widget.onBlurViewWidgetCreated(InstaCropViewController._(id));
  }
}

class InstaCropViewController {
  InstaCropViewController._(int id)
      : _channel = MethodChannel('plugins/instagram_cropper_$id');

  final MethodChannel _channel;

  Future<void> getView(bool isDarkTheme) async {
    return await _channel.invokeMethod('getView', isDarkTheme);
  }

  Future<void> setUri(String imageUri, String imageName) async {
    var params = {
      "imageUri": imageUri,
      "imageName": imageName,
    };

    return await _channel.invokeMethod('setUri', params);
  }
}
