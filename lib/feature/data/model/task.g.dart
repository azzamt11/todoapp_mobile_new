// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['ID'] as int?,
      title: json['title'] as String?,
      priority: json['priority'] as String?,
      deadline: json['deadline'] as String?,
      done: json['done'] as String?,
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

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'ID': instance.id,
      'title': instance.title,
      'priority': instance.priority,
      'deadline': instance.deadline,
      'done': instance.done,
      'CreatedAt': instance.createdAt?.toIso8601String(),
      'UpdatedAt': instance.updatedAt?.toIso8601String(),
      'DeletedAt': instance.deletedAt?.toIso8601String(),
      'archived': instance.archived,
    };
