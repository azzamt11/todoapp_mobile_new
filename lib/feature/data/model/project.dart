
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  @JsonKey(name:'id')
  final int? id;
  @JsonKey(name:'title')
  final String? title;
  @JsonKey(name:'created_at')
  final DateTime? createdAt;
  @JsonKey(name:'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @JsonKey(name:'archived')
  final bool? archived;

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