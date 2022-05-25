// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Types _$TypesFromJson(Map<String, dynamic> json) => Types(
      json['name'] as String?,
      (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$TypesToJson(Types instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
