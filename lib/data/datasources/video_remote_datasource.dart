import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../models/file_response_model.dart';

part 'video_remote_datasource.g.dart';

@RestApi(baseUrl: "https://api.escuelajs.co/api/v1")
abstract class VideoRemoteDataSource {
  factory VideoRemoteDataSource(Dio dio, {String baseUrl}) = _VideoRemoteDataSource;

  @POST("/files/upload")
  @MultiPart()
  @Headers(<String, dynamic>{"Content-Type": "multipart/form-data"})
  Future<FileResponseModel> uploadVideo(@Part(name: "file") File file);
}
