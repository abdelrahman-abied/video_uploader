class VideoUploadResult {
  final String? originalName;
  final String? filename;
  final String? location;
  final bool isSuccess;
  final String? errorMessage;

  VideoUploadResult({this.originalName, this.filename, this.location, required this.isSuccess, this.errorMessage});

  factory VideoUploadResult.success({
    required String originalName,
    required String filename,
    required String location,
  }) {
    return VideoUploadResult(originalName: originalName, filename: filename, location: location, isSuccess: true);
  }

  factory VideoUploadResult.failure({required String errorMessage}) {
    return VideoUploadResult(isSuccess: false, errorMessage: errorMessage);
  }
}
