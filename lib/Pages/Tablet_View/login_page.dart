import "package:flutter/material.dart";
import "package:prof_work/Components/Mobile_View/Button.dart";
import 'package:prof_work/Components/Mobile_View/MyTextField.dart';

class TabletLoginPage extends StatefulWidget {
  const TabletLoginPage({super.key});

  @override
  State<TabletLoginPage> createState() => _TabletLoginPageState();
}

class _TabletLoginPageState extends State<TabletLoginPage> {
  bool _isLoading = false; // 👈 for loader

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API or authentication process
    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Successful!")));
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    double ratio = width > height ? width : height;
    return Scaffold(
      backgroundColor: Colors.grey,
      // appBar: AppBar(
      //   title: Text("Welcome Back"),
      //   centerTitle: true,
      //   backgroundColor: Colors.grey,
      // ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: height / 20,
            horizontal: width / 90,
          ),
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.2,
            // vertical: height * 0.2,
          ),
          // height: height * 0.6,
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
                  hintText: "Username",
                  height: height / 10,
                  width: width,
                  fillColor: Colors.grey,
                  obscureText: false,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  height: height / 10,
                  width: width,
                  fillColor: Colors.grey,
                  obscureText: true,
                ),
                SizedBox(height: height / 50),
                // MyButton(
                //   height: height / 100 * 80,
                //   width: width / 100 * 90,
                //   text: "Login",
                // ),
                MyButton(
                  height: height / 100 * 70,
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
