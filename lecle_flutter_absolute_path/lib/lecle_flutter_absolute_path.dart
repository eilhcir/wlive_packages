import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

/// Class implement get file absolute path method
class LecleFlutterAbsolutePath {
  /// Method channel to invoke method call
  static const MethodChannel _channel =
      MethodChannel('lecle_flutter_absolute_path');

  /// Gets absolute path of the file from android URI or iOS PHAsset identifier.
  /// The return of this method can be used directly with flutter [File] class.
  ///
  /// If you want to change the temp file's name or extension you can use [outputFileName]
  /// and [fileExtension] properties.
  static Future<String?> getAbsolutePath({
    required String uri,
    String? outputFileName,
    String? fileExtension,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'uri': uri,
      'outputFileName': outputFileName,
      'fileExtension': fileExtension ?? _getFileExtensionFromUri(uri),
    };
    final String? path = await _channel.invokeMethod('getAbsolutePath', params);
    return path;
  }

  /// Separate the file's extension from the uri to use for the export file.
  /// If user provide their own type this function will be ignored.
  static String? _getFileExtensionFromUri(String uri) {
    var ex = path.extension(uri);

    if (ex.isNotEmpty) {
      return ex.replaceFirst('.', '');
    }

    return null;
  }
}
