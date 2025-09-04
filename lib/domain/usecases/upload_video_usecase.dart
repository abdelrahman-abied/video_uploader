import 'dart:io';

import '../entities/video_upload_result.dart';
import '../repositories/video_repository.dart';

class UploadVideoUseCase {
  final VideoRepository repository;

  UploadVideoUseCase(this.repository);

  Future<VideoUploadResult> execute(File videoFile) async {
    if (!await videoFile.exists()) {
      return VideoUploadResult.failure(errorMessage: 'Video file does not exist');
    }

    try {
      return await repository.uploadVideo(videoFile);
    } catch (e) {
      return VideoUploadResult.failure(errorMessage: 'Failed to upload video: $e');
    }
  }
}
