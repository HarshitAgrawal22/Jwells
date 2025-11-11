import 'package:isar/isar.dart';
import 'package:prof_work/Models/Token.dart';
import 'dart:io';
import 'package:prof_work/Models/User.dart';
import 'package:path_provider/path_provider.dart';

class JWTDatabase {
  static late Isar isar;

  /// Initialize Database (only once)
  static Future<void> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TokenSchema, UserSchema],
      directory: dir.path,
      inspector: true,
    ); // TODO: remove inspector in production
    // in it add more models to work on
  }

  static Future<void> deleteIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = Directory(dir.path);
    if (await dbPath.exists()) {
      await dbPath.delete(recursive: true);
      print("✅ Isar database deleted.");
    }
  }

  /// Insert or Replace Token
  static Future<void> insertOrUpdateToken(
    String accessToken,
    String refreshToken,
  ) async {
    final existingToken = await getToken();

    final token = Token()
      ..AccessToken = accessToken
      ..RefreshToken = refreshToken
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.tokens.put(token); // put() updates if same ID exists
    });
  }

  /// Fetch the single token from DB
  static Future<Token?> getToken() async {
    final tokens = await isar.tokens.where().findAll();
    if (tokens.isNotEmpty) {
      return tokens.first;
    }
    return null;
  }

  /// Delete all tokens
  static Future<void> deleteToken() async {
    await isar.writeTxn(() async {
      await isar.tokens.clear(); // removes all
    });
  }

  static Future<void> insertUser(
    String username,
    String password,
    String role,
    bool isVerified,
  ) async {
    final user = User()
      ..username = username
      ..role = role
      ..password = password
      ..isVerified = isVerified;

    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  static Future<User?> getUser(String username) async {
    final user = await isar.users
        .filter()
        .usernameEqualTo(username)
        .findFirst();
    return user;
  }

  static Future<bool> deleteUser(String username) async {
    try {
      await isar.writeTxn(() async {
        await isar.users.filter().usernameEqualTo(username).deleteFirst();
      });
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  static Future<void> updateUser(String username, User updatedUser) async {
    final user = await getUser(username);
    if (user != null) {
      // updatedUser.id = user.id; // retain the same ID
      await isar.writeTxn(() async {
        await isar.users.put(updatedUser);
      });
    }
  }
}

// 🧱 1️⃣ Core Principles

// Each table = one Isar @Collection() model

// Relationships use:

// IsarLink<T> → one-to-one

// IsarLinks<T> → one-to-many

// Every entity has:

// A local autoIncrement id (Isar’s ID)

// A serverId (from Django, optional)

// A lastModified timestamp (for sync)

// final companies = await LocalDatabase.isar.companys.where().findAll();

// for (var c in companies) {
//   await c.employees.load();
//   await c.transactions.load();

//   print('Company: ${c.name}');
//   for (var e in c.employees) {
//     print(' → Employee: ${e.name}');
//   }
//   for (var t in c.transactions) {
//     print(' → Transaction: ${t.amount}');
//   }
// }






// final company = Company()
//   ..name = "TechCorp"
//   ..address = "New Delhi";

// final emp1 = Employee()..name = "Harshit"..designation = "Manager";
// final emp2 = Employee()..name = "Amit"..designation = "Accountant";

// final txn1 = Transaction()
//   ..amount = 12000
//   ..date = DateTime.now()
//   ..type = "credit";

// final txn2 = Transaction()
//   ..amount = 5000
//   ..date = DateTime.now()
//   ..type = "debit";

// company.employees.addAll([emp1, emp2]);
// company.transactions.addAll([txn1, txn2]);

// await LocalDatabase.isar.writeTxn(() async {
//   await LocalDatabase.isar.companys.put(company);
//   await company.employees.save();
//   await company.transactions.save();
// });

