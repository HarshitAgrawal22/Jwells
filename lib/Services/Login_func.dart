import 'package:prof_work/DB/JWTDatabase.dart';
import 'package:prof_work/Models/DTOs/ApiResponseDTOs.dart';
import 'package:prof_work/Models/Token.dart';
import 'package:prof_work/Models/User.dart';
import "package:prof_work/Utils/check_Internet.dart";
import 'package:prof_work/APis/Auth.dart';

class Login {
  static Future<String> authenticate(String username, String password) async {
    // if (await isDeviceConnected()) {
    //   // Make Api call for login
    //   LoginResponseDTO loginresult = await AuthAPIService.login(
    //     username,
    //     password,
    //   );
    //   print("L0gining in live");
    //   if (loginresult.success) {
    //     User? user = await JWTDatabase.getUser(username);
    //     if (user == null) {
    //       User newUser = User();
    //       newUser.username = username;
    //       newUser.password = password;
    //       newUser.isVerified = true;
    //       await JWTDatabase.insertUser(username, password, "own", true);
    //     } else {
    //       if (!user.isVerified) {
    //         user.password = password;
    //         user.username = username;
    //         user.isVerified = true;
    //         await JWTDatabase.updateUser(username, user);
    //       }
    //     }
    //     return "Ok";
    //   } else {
    //     return "Live Login failed";
    //   }
    // }

    final user = await JWTDatabase.getUser(username);
    if (user != null) {
      if (user.password == password) {
        Token? token = await JWTDatabase.getToken();
        if (user.isVerified == false || token == null) {
          return "User not verified";
        }

        return "Ok";
      }
      return "Invalid password";
    }
    return "User not found";
  }
}
