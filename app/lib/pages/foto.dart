import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({Key? key}) : super(key: key);

  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> cameras;
  bool _isCameraInitialized = false;
  XFile? _image;
  static const String usuario = 'Default User'; // Defina o usuário aqui
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
    // Automatically capture the image when the camera is ready
    _getImage();
  }

  Future<void> _getImage() async {
    try {
      if (!_isCameraInitialized) return;
      final XFile image = await _cameraController.takePicture();
      setState(() {
        _image = image;
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _postImage() async {
    if (_image == null || _latitude == null || _longitude == null) return;

    final bytes = await _image!.readAsBytes();
    final base64Image = base64Encode(bytes);
    final response = await http.post(
      Uri.parse('http://m2.guilhermesperb.com.br/new'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario': usuario,
        'imagem': base64Image,
        'latitude': _latitude,
        'longitude': _longitude,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image posted successfully')));
      Navigator.pop(context); // Volta para a tela anterior após postar a imagem
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to post image')));
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image == null
                ? _isCameraInitialized
                    ? CameraPreview(_cameraController)
                    : CircularProgressIndicator()
                : Image.file(File(_image!.path)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Get Current Location'),
            ),
            ElevatedButton(
              onPressed: _postImage,
              child: Text('Post Image'),
            ),
          ],
        ),
      ),
    );
  }
}
