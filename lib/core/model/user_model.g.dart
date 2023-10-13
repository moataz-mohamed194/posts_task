// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      gender: json['gender'] as String?,
      height: json['height'] as String?,
      birthDay: json['birth_day'] as String?,
      breastFeed: json['breast_feed'] as bool?,
      fitnessLevel: json['fitness_level'] as String?,
      timeOfCreate: json['time_of_create'] as String?,
      listOfMedicalReport: json['list_of_medical_report'] as List<dynamic>?,
      medicalReport: json['medical_report'] as String?,
      weightFromInBody: json['weight_from_in_body'] as String?,
      pregnant: json['pregnant'] as bool?,
      targetWeight: json['target_weight'] as String?,
      group: json['group'] as String?,
      id: json['id'] as String?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => SocialMediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => SocialMediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      profilePic: json['profile_pic'] as String?,
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => SocialMediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weight: json['weight'] as String?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      countOfPeople: json['count_of_people'] as String?,
      yearsOfExperience: json['years_of_experience'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'gender': instance.gender,
      'birth_day': instance.birthDay,
      'weight': instance.weight,
      'target_weight': instance.targetWeight,
      'fitness_level': instance.fitnessLevel,
      'height': instance.height,
      'weight_from_in_body': instance.weightFromInBody,
      'breast_feed': instance.breastFeed,
      'pregnant': instance.pregnant,
      'medical_report': instance.medicalReport,
      'years_of_experience': instance.yearsOfExperience,
      'count_of_people': instance.countOfPeople,
      'list_of_medical_report': instance.listOfMedicalReport,
      'group': instance.group,
      'email': instance.email,
      'time_of_create': instance.timeOfCreate,
      'user_name': instance.userName,
      'profile_pic': instance.profilePic,
      'id': instance.id,
      'phone': instance.phone,
      'pictures': instance.pictures?.map((e) => e.toJson()).toList(),
      'videos': instance.videos?.map((e) => e.toJson()).toList(),
      'articles': instance.articles?.map((e) => e.toJson()).toList(),
    };
