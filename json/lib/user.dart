import "package:json_annotation/json_annotation.dart";

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;
  @JsonKey(name: "regisration_date_milis")
  final int regisrationDateMilis;

  User(this.name, this.email, this.regisrationDateMilis);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // User.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       email = json['email'];

  Map<String, dynamic> toJson() => _$UserToJson(this);
  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //     };
}
