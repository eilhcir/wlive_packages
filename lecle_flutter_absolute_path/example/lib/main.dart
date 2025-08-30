import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

void main() {
  runApp(const LecleFlutterAbsolutePathDemo());
}

class LecleFlutterAbsolutePathDemo extends StatefulWidget {
  const LecleFlutterAbsolutePathDemo({Key? key}) : super(key: key);

  @override
  State<LecleFlutterAbsolutePathDemo> createState() =>
      _LecleFlutterAbsolutePathDemoState();
}

class _LecleFlutterAbsolutePathDemoState
    extends State<LecleFlutterAbsolutePathDemo> {
  List<String> _absolutePaths = [];

  // Get images messages are asynchronous, so we initialize in an async method.
  Future<void> getImages() async {
    List<String> absolutePaths = [];
    // Get image messages may fail, so we use if to check if assets data is available.
    // We also handle the message potentially returning null.
    List<XFile>? assets = await selectImagesFromGallery();
    if (assets != null) {
      for (var asset in assets) {
        final filePath =
            await LecleFlutterAbsolutePath.getAbsolutePath(uri: asset.path);
        if (filePath != null) {
          absolutePaths.add(filePath);
        }
      }
    }

    // Use with wechat_assets_picker package
    // AssetPicker.pickAssets(context).then((assets) async {
    //   if (assets != null && assets.isNotEmpty) {
    //     for (var asset in assets) {
    //       final file = await asset.file;
    //       if (file != null) {
    //         final filePath = await LecleFlutterAbsolutePath.getAbsolutePath(uri: file.path);
    //         if (filePath != null) {
    //           absolutePaths.add(filePath);
    //         }
    //       }
    //     }
    //   }
    // });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _absolutePaths = List.from(absolutePaths);
    });
  }

  Future<List<XFile>?> selectImagesFromGallery() async {
    ImagePicker picker = ImagePicker();

    return await picker.pickMultiImage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                child: Text('Absolute paths'),
                padding: EdgeInsets.only(bottom: 16.0),
              ),
              ...List.generate(
                _absolutePaths.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child:
                      Text(_absolutePaths[index], textAlign: TextAlign.center),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  LecleFlutterAbsolutePath.getAbsolutePath(uri: 'your_file_uri')
                      .then((path) {
                    print('Path after parse ::: $path');
                  });
                },
                child: const Text('Get file absolute path'),
              ),
              ElevatedButton(
                onPressed: () {
                  getImages();
                },
                child: const Text('Get images'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
