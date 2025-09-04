import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/usecases/upload_video_usecase.dart';

// State class
class VideoUploadState {
  final File? selectedVideo;
  final String status;
  final bool isUploading;
  final bool isPicking;

  const VideoUploadState({
    this.selectedVideo,
    this.status = "No video selected.",
    this.isUploading = false,
    this.isPicking = false,
  });

  VideoUploadState copyWith({File? selectedVideo, String? status, bool? isUploading, bool? isPicking}) {
    return VideoUploadState(
      selectedVideo: selectedVideo ?? this.selectedVideo,
      status: status ?? this.status,
      isUploading: isUploading ?? this.isUploading,
      isPicking: isPicking ?? this.isPicking,
    );
  }

  bool get hasVideo => selectedVideo != null;
}

// StateNotifier
class VideoUploadNotifier extends StateNotifier<VideoUploadState> {
  final UploadVideoUseCase _uploadVideoUseCase;
  final ImagePicker _picker = ImagePicker();

  VideoUploadNotifier(this._uploadVideoUseCase) : super(const VideoUploadState());

  Future<void> pickVideo() async {
    state = state.copyWith(isPicking: true);

    try {
      final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        final videoFile = File(pickedFile.path);
        state = state.copyWith(
          selectedVideo: videoFile,
          status: "Video selected: ${videoFile.path.split('/').last}",
          isPicking: false,
        );
      } else {
        state = state.copyWith(selectedVideo: null, status: "No video selected.", isPicking: false);
      }
    } catch (e) {
      state = state.copyWith(selectedVideo: null, status: "Error picking video: $e", isPicking: false);
    }
  }

  Future<void> uploadVideo() async {
    if (state.selectedVideo == null) {
      state = state.copyWith(status: "Please pick a video first.");
      return;
    }

    state = state.copyWith(isUploading: true, status: "Uploading...");

    try {
      final result = await _uploadVideoUseCase.execute(state.selectedVideo!);

      if (result.isSuccess) {
        state = state.copyWith(
          status: "Video uploaded successfully! Filename: ${result.filename}",
          selectedVideo: null,
          isUploading: false,
        );
      } else {
        state = state.copyWith(status: "Failed to upload video: ${result.errorMessage}", isUploading: false);
      }
    } catch (e) {
      state = state.copyWith(status: "An unexpected error occurred: $e", isUploading: false);
    }
  }

  void reset() {
    state = const VideoUploadState();
  }
}

