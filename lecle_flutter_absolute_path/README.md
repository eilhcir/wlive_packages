# lecle_flutter_absolute_path

A Flutter project to get the absolute path of a file on Android and iOS device.

## Android

Add these permission into your AndroidManifest file

```xml

<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

## iOS

- Add the following lines into your `Info.plist`.

```xml

<key>NSPhotoLibraryUsageDescription</key>
<string>Replace with your permission description.</string>
```

## How to use

- Simply import [lecle_flutter_absolute_path](https://pub.dev/packages/lecle_flutter_absolute_path) package on pub.dev or with the syntax below under 
dependencies in pubspec.yaml file and run flutter command **flutter pub get** in terminal

  `dependencies:`\
  &emsp;`flutter:` \
  &emsp;&emsp;`sdk:flutter`

  `lecle_flutter_absolute_path: <latest version>`

- Add the import below into your dart file

`import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';`

## Example

* **Default use**

```dart

String? filePath = await LecleFlutterAbsolutePath.getAbsolutePath(uri: 'your_file_uri');
```

- You can use with [multi_image_picker](https://pub.dev/packages/multi_image_picker) **(Discontinued)**
  , [wechat_assets_picker](https://pub.dev/packages/wechat_assets_picker) or [image_picker](https://pub.dev/packages/image_picker) to get the assets
  from device and use `lecle_flutter_absolute_path` to get the picked assets absolute paths

* **Use with multi_image_picker (Old example, not recommend to use)**

```dart

final filePath = await LecleFlutterAbsolutePath.getAbsolutePath(uri: asset.identifier);
```
  
* **Use with wechat_assets_picker**

```dart

AssetPicker.pickAssets(context).then((assets) async {
  if (assets != null && assets.isNotEmpty) {
  for (var asset in assets) {
        final file = await asset.file;
        if (file != null) {
          final filePath = await LecleFlutterAbsolutePath.getAbsolutePath(uri: file.path);
          print('Absolute file path ::: $filePath');
        }
      }
    }
});
```
  
* **Use with image_picker**

```dart

final filePath = await LecleFlutterAbsolutePath.getAbsolutePath(uri: asset.path);
```