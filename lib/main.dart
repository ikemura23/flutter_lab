import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MainApp());
}

// Main
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraApp(),
    );
  }
}

// カメラ
class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;
  String imagePath;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // カメラ初期設定
    controller = CameraController(
      cameras[0], //背面カメラのみ
      ResolutionPreset.medium,
      enableAudio: false, //音声は不要
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () => onTakePictureButtonPressed(),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// カメラボタン押下
  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      setState(() {
        imagePath = filePath;
      });
      if (filePath != null) showInSnackBar('Picture saved to $filePath');
    });
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  /// カメラ撮影処理
  Future<String> takePicture() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String dirPath = '${directory.path}/Pictures/flutter';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    try {
      controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
  }

  void logError(String code, String message) =>
      print('Error: $code/nError Message: $message');
}
