// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsModel _$PostsModelFromJson(Map<String, dynamic> json) => PostsModel(
      userName: json['user_name'] as String?,
      timeToShare: json['time_to_share'] as String?,
      uid: json['uid'] as String?,
      liked:
          (json['liked'] as List<dynamic>?)?.map((e) => e as String).toList(),
      comment: (json['comment'] as List<dynamic>?)
          ?.map((e) => CommentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      postBody: json['post_body'] as String?,
      postImage: json['post_image'] as String?,
    );

Map<String, dynamic> _$PostsModelToJson(PostsModel instance) =>
    <String, dynamic>{
      'post_body': instance.postBody,
      'post_image': instance.postImage,
      'time_to_share': instance.timeToShare,
      'uid': instance.uid,
      'user_name': instance.userName,
      'liked': instance.liked,
      'comment': instance.comment?.map((e) => e.toJson()).toList(),
    };
