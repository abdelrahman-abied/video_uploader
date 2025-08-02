import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(createToJson: false)
class FileResponse {
  FileResponse({required this.originalname, required this.filename, required this.location});

  final String? originalname;
  final String? filename;
  final String? location;

  factory FileResponse.fromJson(Map<String, dynamic> json) => _$FileResponseFromJson(json);
}
