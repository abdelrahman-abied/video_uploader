import 'dart:io';

import '../entities/video_upload_result.dart';

abstract class VideoRepository {
  Future<VideoUploadResult> uploadVideo(File videoFile);
}
