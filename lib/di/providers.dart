import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/video_remote_datasource.dart';
import '../data/repositories/video_repository_impl.dart';
import '../domain/repositories/video_repository.dart';
import '../domain/usecases/upload_video_usecase.dart';
import '../presentation/providers/video_upload_notifier.dart';

// Dio provider
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
});

// Data source provider
final videoRemoteDataSourceProvider = Provider<VideoRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return VideoRemoteDataSource(dio);
});

// Repository provider
final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return VideoRepositoryImpl(dio: dio);
});

// Use case provider
final uploadVideoUseCaseProvider = Provider<UploadVideoUseCase>((ref) {
  final repository = ref.watch(videoRepositoryProvider);
  return UploadVideoUseCase(repository);
});

// State notifier provider
final videoUploadNotifierProvider = StateNotifierProvider<VideoUploadNotifier, VideoUploadState>((ref) {
  final useCase = ref.watch(uploadVideoUseCaseProvider);
  return VideoUploadNotifier(useCase);
});
