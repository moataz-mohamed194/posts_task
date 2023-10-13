import 'package:json_annotation/json_annotation.dart';

part 'social_media_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SocialMediaModel {
  String? id;
  String? body;
  String? title;
  String? url;

  SocialMediaModel(
      {this.id,
        this.title,
        this.url,
        this.body});
  factory SocialMediaModel.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaModelToJson(this);
}