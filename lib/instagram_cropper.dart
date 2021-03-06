import 'dart:async';

import 'package:flutter/foundation.dart';
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
  Key _key;

  @override
  void initState() {
    super.initState();
    _key = Key('CropperView');
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins/instagram_cropper',
        onPlatformViewCreated: _onPlatformViewCreated,
        key: _key,
      );
    }
    return const Text('iOS platform version is not implemented yet.');
  }

  void _onPlatformViewCreated(int id) {
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
    return await _channel.invokeMethod('setUri', value);
  }
}
