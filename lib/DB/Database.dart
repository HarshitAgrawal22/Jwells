import 'package:isar/isar.dart';
import 'package:prof_work/Models/Token.dart';
import 'package:path_provider/path_provider.dart';

class JWTDatabase {
  static late Isar isar;
  // final token = new Token();
  //Initailize Database
  static Future<void> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([TokenSchema], directory: dir.path);
  }

  // Read from DB
  // Write to DB

  Future<void> insertToken(String AccessToken, String RefreshToken) async {
    Token token = Token(
      AccessToken: AccessToken,
      RefreshToken: RefreshToken,
      createdAt: DateTime.now(),
    );
    await isar.writeTxn(() async {
      await isar.tokens.put(token);
    });
  }

  // Delete from DB
  // Update DB
}
