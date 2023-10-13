import 'package:json_annotation/json_annotation.dart';

import 'comments_model.dart';
part 'posts_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PostsModel {
  String? postBody;
  String? postImage;
  String? timeToShare;
  String? uid;
  String? userName;
  List<String>? liked;
  List<CommentsModel>? comment;

  PostsModel(
      {this.userName,
        this.timeToShare,
        this.uid,
        this.liked,
        this.comment,
        this.postBody,
        this.postImage});
  factory PostsModel.fromJson(Map<String, dynamic> json) =>
      _$PostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostsModelToJson(this);
}