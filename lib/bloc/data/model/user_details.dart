
import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  @JsonKey(name:'userId')
  final String? userId;
  @JsonKey(name:'firstName')
  final String? firstName;
  @JsonKey(name:'lastName')
  final String? lastName;
  @JsonKey(name:'email')
  final String? email;

  UserDetails(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email
      });

  factory UserDetails.fromJson(final Map<String, dynamic> json) {
    return _$UserDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

}