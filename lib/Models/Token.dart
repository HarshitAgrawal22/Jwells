import 'package:isar/isar.dart';
//dart run build_runner build,  to generate the part file

//dart run build_runner build --delete-conflicting-outputs

part 'Token.g.dart';

@Collection()
class Token {
  Id id = Isar.autoIncrement;
  late String AccessToken;
  late String RefreshToken;
  late DateTime createdAt;

  Token({
    required this.AccessToken,
    required this.RefreshToken,
    required this.createdAt,
  });
}
