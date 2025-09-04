import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/providers.dart';
import '../providers/video_upload_notifier.dart';
import '../widgets/video_player_widget.dart';

class VideoUploadScreen extends ConsumerWidget {
  const VideoUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoUploadState = ref.watch(videoUploadNotifierProvider);
    final videoUploadNotifier = ref.read(videoUploadNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Uploader'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPickVideoButton(videoUploadState, videoUploadNotifier),
            const SizedBox(height: 20),
            _buildVideoPlayer(videoUploadState),
            const SizedBox(height: 20),
            _buildUploadButton(videoUploadState, videoUploadNotifier),
            const SizedBox(height: 20),
            _buildProgressIndicator(videoUploadState),
            const SizedBox(height: 10),
            _buildStatusText(videoUploadState),
          ],
        ),
      ),
    );
  }

  Widget _buildPickVideoButton(VideoUploadState state, VideoUploadNotifier notifier) {
    return ElevatedButton.icon(
      onPressed: state.isPicking || state.isUploading ? null : notifier.pickVideo,
      icon: state.isPicking
          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
          : const Icon(Icons.video_library),
      label: Text(state.isPicking ? 'Picking...' : 'Pick Video'),
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
    );
  }

  Widget _buildVideoPlayer(VideoUploadState state) {
    if (state.selectedVideo != null) {
      return VideoPlayerWidget(videoFile: state.selectedVideo!);
    } else {
      return Container(
        height: 200,
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam_off, size: 64, color: Colors.grey),
              SizedBox(height: 8),
              Text('No video selected', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildUploadButton(VideoUploadState state, VideoUploadNotifier notifier) {
    return ElevatedButton.icon(
      onPressed: (state.isUploading || !state.hasVideo) ? null : notifier.uploadVideo,
      icon: state.isUploading
          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : const Icon(Icons.cloud_upload),
      label: Text(state.isUploading ? 'Uploading...' : 'Upload Video'),
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
    );
  }

  Widget _buildProgressIndicator(VideoUploadState state) {
    if (!state.isUploading) return const SizedBox.shrink();

    return LinearProgressIndicator(
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }

  Widget _buildStatusText(VideoUploadState state) {
    final isError = state.status.contains("Error") || state.status.contains("Failed");

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isError ? Colors.red[50] : Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isError ? Colors.red[200]! : Colors.blue[200]!),
      ),
      child: Text(
        state.status,
        textAlign: TextAlign.center,
        style: TextStyle(color: isError ? Colors.red[700] : Colors.blue[700], fontWeight: FontWeight.w500),
      ),
    );
  }
}
