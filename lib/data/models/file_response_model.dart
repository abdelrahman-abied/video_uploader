import 'package:json_annotation/json_annotation.dart';

part 'file_response_model.g.dart';

@JsonSerializable(createToJson: false)
class FileResponseModel {
  final String? originalname;
  final String? filename;
  final String? location;

  FileResponseModel({required this.originalname, required this.filename, required this.location});

  factory FileResponseModel.fromJson(Map<String, dynamic> json) => _$FileResponseModelFromJson(json);
}
