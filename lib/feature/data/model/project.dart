
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  @JsonKey(name:'ID')
  final int? id;
  @JsonKey(name:'title')
  final String? title;
  @JsonKey(name:'CreatedAt')
  final DateTime? createdAt;
  @JsonKey(name:'UpdatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'DeletedAt')
  final DateTime? deletedAt;
  @JsonKey(name:'archived')
  final bool? archived;

  Project({
      this.id,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.archived
      });

  factory Project.fromJson(final Map<String, dynamic> json) {
    debugPrint("json_response= ${json.toString()}");
    return _$ProjectFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

}