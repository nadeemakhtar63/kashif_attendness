// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class AddStudentwithface extends StatefulWidget {
//   const AddStudentwithface({Key? key}) : super(key: key);
//
//   @override
//   State<AddStudentwithface> createState() => _AddStudentwithfaceState();
// }
//
// class _AddStudentwithfaceState extends State<AddStudentwithface> {
//   late File jsonFile;
//   dynamic _scanResults;
//   late CameraController _camera;
//   var interpreter;
//   bool _isDetecting = false;
//   CameraLensDirection _direction = CameraLensDirection.front;
//   dynamic data = {};
//   double threshold = 1.0;
//   late Directory tempDir;
//   late List e1;
//   bool _faceFound = false;
//   final TextEditingController _name = new TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//     _initializeCamera();
//   }
//
//   Future loadModel() async {
//     try {
//       final gpuDelegateV2 = tfl.GpuDelegateV2(
//           options: tfl.GpuDelegateOptionsV2(
//             false,
//             tfl.TfLiteGpuInferenceUsage.fastSingleAnswer,
//             tfl.TfLiteGpuInferencePriority.minLatency,
//             tfl.TfLiteGpuInferencePriority.auto,
//             tfl.TfLiteGpuInferencePriority.auto,
//           ));
//
//       var interpreterOptions = tfl.InterpreterOptions()
//         ..addDelegate(gpuDelegateV2);
//       interpreter = await tfl.Interpreter.fromAsset('mobilefacenet.tflite',
//           options: interpreterOptions);
//     } on Exception {
//       print('Failed to load model.');
//     }
//   }
//   void _initializeCamera() async {
//     await loadModel();
//     CameraDescription description = await getCamera(_direction);
//
//     ImageRotation rotation = rotationIntToImageRotation(
//       description.sensorOrientation,
//     );
//     _camera =
//         CameraController(description, ResolutionPreset.low, enableAudio: false);
//     await _camera.initialize();
//     await Future.delayed(Duration(milliseconds: 500));
//     tempDir = await getApplicationDocumentsDirectory();
//     String _embPath = tempDir.path + '/emb.json';
//     jsonFile = new File(_embPath);
//     if (jsonFile.existsSync()) data = json.decode(jsonFile.readAsStringSync());
//
//     _camera.startImageStream((CameraImage image) {
//       if (_camera != null) {
//         if (_isDetecting) return;
//         _isDetecting = true;
//         String res;
//         dynamic finalResult = Multimap<String, Face>();
//         detect(image, _getDetectionMethod(), rotation).then(
//               (dynamic result) async {
//             if (result.length == 0)
//               _faceFound = false;
//             else
//               _faceFound = true;
//             Face _face;
//             imglib.Image convertedImage =
//             _convertCameraImage(image, _direction);
//             for (_face in result) {
//               double x, y, w, h;
//               x = (_face.boundingBox.left - 10);
//               y = (_face.boundingBox.top - 10);
//               w = (_face.boundingBox.width + 10);
//               h = (_face.boundingBox.height + 10);
//               imglib.Image croppedImage = imglib.copyCrop(
//                   convertedImage, x.round(), y.round(), w.round(), h.round());
//               croppedImage = imglib.copyResizeCropSquare(croppedImage, 112);
//               // int startTime = new DateTime.now().millisecondsSinceEpoch;
//               res = _recog(croppedImage);
//               // int endTime = new DateTime.now().millisecondsSinceEpoch;
//               // print("Inference took ${endTime - startTime}ms");
//               finalResult.add(res, _face);
//             }
//             setState(() {
//               _scanResults = finalResult;
//             });
//
//             _isDetecting = false;
//           },
//         ).catchError(
//               (_) {
//             _isDetecting = false;
//           },
//         );
//       }
//     });
//   }
//
//   HandleDetection _getDetectionMethod() {
//     final faceDetector = FirebaseVision.instance.faceDetector(
//       FaceDetectorOptions(
//         mode: FaceDetectorMode.accurate,
//       ),
//     );
//     return faceDetector.processImage;
//   }
//
//   Widget _buildResults() {
//     const Text noResultsText = const Text('');
//     if (_scanResults == null ||
//         _camera == null ||
//         !_camera.value.isInitialized) {
//       return noResultsText;
//     }
//     CustomPainter painter;
//
//     final Size imageSize = Size(
//       _camera.value.previewSize.height,
//       _camera.value.previewSize.width,
//     );
//     painter = FaceDetectorPainter(imageSize, _scanResults);
//     return CustomPaint(
//       painter: painter,
//     );
//   }
//
//   Widget _buildImage() {
//     if (_camera == null || !_camera.value.isInitialized) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//
//     return Container(
//       constraints: const BoxConstraints.expand(),
//       child: _camera == null
//           ? const Center(child: null)
//           : Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           CameraPreview(_camera),
//           _buildResults(),
//         ],
//       ),
//     );
//   }
//
//   void _toggleCameraDirection() async {
//     if (_direction == CameraLensDirection.back) {
//       _direction = CameraLensDirection.front;
//     } else {
//       _direction = CameraLensDirection.back;
//     }
//     await _camera.stopImageStream();
//     await _camera.dispose();
//
//     setState(() {
//       _camera = null;
//     });
//
//     _initializeCamera();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
