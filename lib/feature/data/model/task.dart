import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  @JsonKey(name:'ID')
  final int? id;
  @JsonKey(name:'title')
  final String? title;
  @JsonKey(name:'priority')
  final String? priority;
  @JsonKey(name:'deadline')
  final String? deadline;
  @JsonKey(name:'done')
  final bool? done;
  @JsonKey(name:'CreatedAt')
  final DateTime? createdAt;
  @JsonKey(name:'UpdatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'DeletedAt')
  final DateTime? deletedAt;
  @JsonKey(name:'archived')
  final bool? archived;

  Task({
      this.id,
      this.title,
      this.priority,
      this.deadline,
      this.done,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.archived
      });

  factory Task.fromJson(final Map<String, dynamic> json) {
    debugPrint("json_response= ${json.toString()}");
    return _$TaskFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

}