import 'package:isar/isar.dart';
import "package:uuid/uuid.dart";
part "User.g.dart";

@Collection()
class User {
  Id id = Isar.autoIncrement;

  // late String uuid = const Uuid().v4();
  // late String name;

  @Index(unique: true)
  late String uuid = const Uuid().v4();
  @Index(unique: true)
  late String username;
  late String password;
  late bool isVerified;
  late String role;
}
// TODO: make login functionality working with this User model