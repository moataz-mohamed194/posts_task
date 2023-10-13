// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialMediaModel _$SocialMediaModelFromJson(Map<String, dynamic> json) =>
    SocialMediaModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$SocialMediaModelToJson(SocialMediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'title': instance.title,
      'url': instance.url,
    };
