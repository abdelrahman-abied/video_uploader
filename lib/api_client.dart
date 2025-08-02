import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:video_uploader/response.dart';

part 'api_client.g.dart'; // This file will be generated

@RestApi(baseUrl: "https://api.escuelajs.co/api/v1") // <<< Changed base URL to file.io
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // file.io's API is simpler; it expects the file directly in the multipart form,
  // usually named "file". We don't need a separate "description" for file.io.
  @POST("/files/upload") // <<< Added the expiry parameter directly to the URL
  @MultiPart()
  @Headers(<String, dynamic>{
    "Content-Type": "multipart/form-data",
  })
  Future<FileResponse> uploadFileIo(@Part(name: "file") File file) ;
}
