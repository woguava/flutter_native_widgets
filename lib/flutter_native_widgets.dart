import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNativeWidgets {
  static const MethodChannel _channel =
      const MethodChannel('flutter_native_widgets');

  static const String DEFAULT_POSITIVE_BUTTON_TEXT = "OK";
  static const String DEFAULT_NEGATIVE_BUTTON_TEXT = "Cancel";

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> showConfirmDialog({
    String title,
    String message,
    String positiveButtonText = 'OK',
    String negativeButtonText = 'Cancel',
    int positiveButtonTextColor = -1,
    int negativeButtonTextColor = -1,
  }) async {
    return await _channel.invokeMethod('showConfirmDialog',{
      'title' : title,
      'message' : message,
      'positiveButtonText' : positiveButtonText,
      'negativeButtonText' : negativeButtonText,
      'positiveButtonTextColor' : positiveButtonTextColor,
      'negativeButtonTextColor' : negativeButtonTextColor,
    });
  }
}
