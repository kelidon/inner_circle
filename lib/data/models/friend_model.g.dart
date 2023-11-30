// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
      name: json['name'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      id: json['id'] as String,
    );

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthday': instance.birthday.toIso8601String(),
    };
