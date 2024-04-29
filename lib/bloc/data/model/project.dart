
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  @JsonKey(name:'id')
  final int? id;
  @JsonKey(name:'title')
  final String? title;
  @JsonKey(name:'createdAt')
  final DateTime? createdAt;
  @JsonKey(name:'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'deletedAt')
  final DateTime? deletedAt;
  @JsonKey(name:'archived')
  final DateTime? archived;

  Project(
      {this.id,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.archived
      });

  factory Project.fromJson(final Map<String, dynamic> json) {
    return _$ProjectFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

}