import 'package:json_annotation/json_annotation.dart';

part 'comments_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CommentsModel {
  String? userId;
  String? value;
  String? userName;

  CommentsModel(
      {this.userId,
        this.userName,
        this.value});
  factory CommentsModel.fromJson(Map<String, dynamic> json) =>
      _$CommentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsModelToJson(this);
}