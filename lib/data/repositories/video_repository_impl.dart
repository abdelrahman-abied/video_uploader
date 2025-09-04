import 'dart:io';

import 'package:dio/dio.dart';

import '../../domain/entities/video_upload_result.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/video_remote_datasource.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl({required Dio dio}) : remoteDataSource = VideoRemoteDataSource(dio);

  @override
  Future<VideoUploadResult> uploadVideo(File videoFile) async {
    try {
      final response = await remoteDataSource.uploadVideo(videoFile);

      if (response.filename != null) {
        return VideoUploadResult.success(
          originalName: response.originalname ?? '',
          filename: response.filename!,
          location: response.location ?? '',
        );
      } else {
        return VideoUploadResult.failure(errorMessage: 'Upload failed: No filename received');
      }
    } on DioException catch (e) {
      return VideoUploadResult.failure(errorMessage: 'Network error: ${e.response?.statusCode ?? e.type}');
    } catch (e) {
      return VideoUploadResult.failure(errorMessage: 'Unexpected error: $e');
    }
  }
}
