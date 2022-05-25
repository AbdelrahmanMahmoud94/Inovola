// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      json['title'] as String?,
      (json['img'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['interest'] as String?,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['address'] as String?,
      json['trainerImg'] as String?,
      (json['reservTypes'] as List<dynamic>?)
          ?.map((e) => Types.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['trainerInfo'] as String?,
      json['occasionDetail'] as String?,
      json['trainerName'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'title': instance.title,
      'img': instance.img,
      'interest': instance.interest,
      'date': instance.date?.toIso8601String(),
      'address': instance.address,
      'trainerName': instance.trainerName,
      'trainerImg': instance.trainerImg,
      'trainerInfo': instance.trainerInfo,
      'occasionDetail': instance.occasionDetail,
      'reservTypes': instance.reservTypes,
    };
