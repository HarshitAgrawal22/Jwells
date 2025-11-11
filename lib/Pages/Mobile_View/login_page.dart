import "package:flutter/material.dart";
import "package:prof_work/Components/Mobile_View/Button.dart";
import "package:prof_work/Components/Mobile_View/MyTextField.dart";
import "package:prof_work/DB/JWTDatabase.dart";
import 'package:prof_work/Services/Login_func.dart';
import "package:prof_work/Pages/Mobile_View/Create_company.dart";

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({super.key});

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  void _login() async {
    String result = await Login.authenticate(
      usernameController.text,
      passwordController.text,
    );
    setState(() {
      _isLoading = true;
    });
    if (result == "Ok") {
      // Navigator.pushNamed(context, '/home');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Successful!")));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateCompanyPage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _handleLogin() async {
    setState(() {
      _login();
    });
    // TODO: Add your login logic here
    // TODO: Disable inputs when button is clicked
    // Use Provider for state management

    // Simulate API or authentication process
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // double ratio = width > height ? width : height;
    // JWTDatabase.insertUser("harshit", "1810", "own", true);
    // JWTDatabase.insertOrUpdateToken("access_token", "refresh_token");
    return Scaffold(
      backgroundColor: Colors.grey,

      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: height / 30,
            horizontal: width / 90,
          ),
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.1,
            // vertical: height * 0.2,
          ),
          height: height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.person, size: 80),
                    Text(
                      "Welcome Back",
                      style: TextStyle(fontSize: height * 0.02),
                    ),

                    Text(
                      "This Firm awaits you",
                      style: TextStyle(fontSize: height * 0.015),
                    ),
                  ],
                ),
                SizedBox(height: height / 40),
                MyTextField(
                  controller: usernameController,
                  height: height / 100,
                  width: width,
                  hintText: "Username",
                  fillColor: Colors.grey,
                  obscureText: false,
                ),
                MyTextField(
                  controller: passwordController,
                  height: height / 10,
                  width: width,
                  hintText: "Password",
                  fillColor: Colors.grey,
                  obscureText: true,
                ),
                SizedBox(height: height / 50),
                MyButton(
                  height: height / 100 * 50,
                  width: width,
                  item: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.grey,
                          strokeWidth: 3,
                        )
                      : const Text("Login"),
                  onPressed: _isLoading ? () {} : _handleLogin,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New User?"),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Register Here",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
