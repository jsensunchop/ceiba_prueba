// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['body'] as String,
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
