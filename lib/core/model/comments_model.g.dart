// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsModel _$CommentsModelFromJson(Map<String, dynamic> json) =>
    CommentsModel(
      userId: json['user_id'] as String?,
      userName: json['user_name'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$CommentsModelToJson(CommentsModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'value': instance.value,
      'user_name': instance.userName,
    };
