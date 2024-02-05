import 'dart:convert';

import 'package:json/user.dart';

void main(List<String> args) {
  const String jsonString = """
{
  "name": "jhon",
  "email": "jhon@gmail.com",
  "regisration_date_milis": 123456789
}
""";

  Map<String, dynamic> userMap = jsonDecode(jsonString);
  var user = User.fromJson(userMap);

  print("Halo, ${user.name}");
  print("Email verification link send to:, ${user.email}");

  String json = jsonEncode(user);

  print("String json: ${json}");
}
