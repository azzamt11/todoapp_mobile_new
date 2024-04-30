// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['ID'] as int?,
      title: json['title'] as String?,
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'] == null
          ? null
          : DateTime.parse(json['DeletedAt'] as String),
      archived: json['archived'] as bool?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'ID': instance.id,
      'title': instance.title,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
      'DeletedAt': instance.deletedAt?.toIso8601String(),
      'archived': instance.archived,
    };
