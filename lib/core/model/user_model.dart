import 'package:json_annotation/json_annotation.dart';

import 'social_media_model.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserModel {
  String? gender;
  String? birthDay;
  String? weight;
  String? targetWeight;
  String? fitnessLevel;
  String? height;
  String? weightFromInBody;
  bool? breastFeed;
  bool? pregnant;
  String? medicalReport;
  String? yearsOfExperience;
  String? countOfPeople;
  List? listOfMedicalReport;
  String? group;
  String? email;
  String? timeOfCreate;
  String? userName;
  String? profilePic;
  String? id;
  String? phone;
  List<SocialMediaModel>? pictures = [];
  List<SocialMediaModel>? videos = [];
  List<SocialMediaModel>? articles = [];

  UserModel(
      {this.gender,
      required this.height,
      required this.birthDay,
      this.breastFeed,
      this.fitnessLevel,
      this.timeOfCreate,
      required this.listOfMedicalReport,
      this.medicalReport,
      required this.weightFromInBody,
      this.pregnant,
      required this.targetWeight,
      this.group,
      this.id,
      this.articles,
      this.videos,
      this.profilePic,
      this.pictures,
      required this.weight,
      this.userName,
      this.email,
      this.phone,
      this.countOfPeople,
      this.yearsOfExperience});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
