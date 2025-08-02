import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/api_client.dart'; 













void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Uploader',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const VideoUploadScreen(),
    );
  }
}

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({super.key, this.child});
  final Widget? child;
  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  File? _pickedVideo;
  final ImagePicker _picker = ImagePicker();
  late ApiClient _apiClient;
  String _uploadStatus = "No video selected.";
  bool _isUploading = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(contentType: 'application/json'));

    _apiClient = ApiClient(dio);
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedVideo = File(pickedFile.path);
          
          _uploadStatus = "Video selected: ${_pickedVideo!.path.split('/').last}";
        });
        _controller = VideoPlayerController.networkUrl(Uri.parse(pickedFile.path))..initialize().then((_) {
          setState(() {
            _controller.play();
          });
        });
      } else {
        setState(() {
          _uploadStatus = "Video selection cancelled.";
        });
      }
    } catch (e) {
      setState(() {
        _uploadStatus = "Error picking video: $e";
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_pickedVideo == null) {
      setState(() {
        _uploadStatus = "Please pick a video first.";
      });
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadStatus = "Uploading...";
    });

    try {

      final response = await _apiClient.uploadFileIo(_pickedVideo!);

      if (response.filename != null) {
        setState(() {
          _uploadStatus = "Video uploaded successfully! Filename: ${response.filename}";
          _pickedVideo = null; 
        });
      } else {
        setState(() {
          _uploadStatus = "Failed to upload video: ${response.filename ?? 'Unknown error'}";
        });
      }
    } on DioException catch (e) {
      setState(() {
        _uploadStatus = "Upload error: ${e.response?.statusCode ?? e.type}";
      });
    } catch (e) {
      setState(() {
        _uploadStatus = "An unexpected error occurred: $e";
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Uploader')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: _isUploading ? null : _pickVideo, child: const Text('Pick Video')),
            const SizedBox(height: 20),
            _pickedVideo != null
                ? AspectRatio(aspectRatio: 1 , child: VideoPlayer(_controller))
                : const Center(child: Icon(Icons.videocam_off, size: 100, color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading || _pickedVideo == null ? null : _uploadVideo,
              child: _isUploading ? const CircularProgressIndicator(color: Colors.white) : const Text('Upload Video'),
            ),
            const SizedBox(height: 20),
            if (_isUploading)
              LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            const SizedBox(height: 10),
            Text(
              _uploadStatus,
              textAlign: TextAlign.center,
              style: TextStyle(color: _uploadStatus.contains("Error") ? Colors.red : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // It's crucial to dispose of the controller to free up resources.
    _controller.dispose();
    super.dispose();
  }
}
