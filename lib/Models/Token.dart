// import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import "package:uuid/uuid.dart";
// import 'package:uuid/uuid.dart';
//dart run build_runner build,  to generate the part file

//dart run build_runner build --delete-conflicting-outputs

part 'Token.g.dart';

@Collection()
class Token {
  // @Id()
  // late String id;
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String uuid = const Uuid().v4();
  @Index(unique: true)
  late String AccessToken;
  late String RefreshToken;
  late DateTime createdAt;

  // Token({
  //   required this.AccessToken,
  //   required this.RefreshToken,
  //   required this.createdAt,
  // });
}
