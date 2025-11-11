import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prof_work/DB/JWTDatabase.dart';
import 'package:prof_work/Models/DTOs/ApiResponseDTOs.dart';
import "package:prof_work/Utils/Holder.dart";

// flutter pub add http
class AuthAPIService {
  // ✅ update this

  /// Login API call
  static Future<LoginResponseDTO> login(
    String username,
    String password,
  ) async {
    // base url is what we are receiving from Holder.dart
    final url = Uri.parse("$baseUrl/login/");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final accessToken = data["access"];
        final refreshToken = data["refresh"];
        final role = data["role"];

        // ✅ Store token locally in Isar
        await JWTDatabase.insertOrUpdateToken(accessToken, refreshToken);

        print("✅ Login successful!");
        return LoginResponseDTO(
          accesstoken: accessToken,
          refreshToken: refreshToken,
          message: "Login successful",
          success: true,
          role: role,
        );
      } else {
        print("❌ Login failed: ${response.body}");
        return LoginResponseDTO(
          accesstoken: "",
          refreshToken: "",
          message: "Login failed",
          success: false,
          role: "",
        );
      }
    } catch (e) {
      print("⚠️ Exception during login: $e");
      return LoginResponseDTO(
        accesstoken: "",
        refreshToken: "",
        message: "Login failed",
        success: false,
        role: "",
      );
    }
  }
}
// 1️⃣ What is CI/CD, Simply?

// CI (Continuous Integration):
// Every time you change code (push to GitHub), your pipeline automatically:

// Pulls the code

// Checks it (lint, style)

// Runs tests

// CD (Continuous Deployment/Delivery):
// After code passes tests, it automatically deploys to your server or hosting service.

// Think of it like:
// Code → Auto-test → Auto-deploy → Live app

// 2️⃣ Key Things You Need to Know

// For a Django backend deploying to PythonAnywhere, you need to understand:

// a) Version Control (Git + GitHub)

// Push code to GitHub

// Understand branches (main, develop)

// b) Python Basics

// Virtual environments (venv)

// Installing packages (pip install)

// Running Django commands (migrate, runserver)

// c) Testing & Linting

// pytest for testing

// flake8 or black for code style

// d) SSH Basics

// SSH keys to access PythonAnywhere

// Basic Linux commands (cd, ls, git pull)

// e) CI/CD Concepts

// YAML workflow files (GitHub Actions uses .yml)

// Jobs & steps

// Secrets management for passwords/API keys

// 3️⃣ How to Create Your First CI/CD Pipeline
// Step 1: Set up GitHub repository

// Create repo for your Django project

// Push your Django project code

// Step 2: Prepare PythonAnywhere

// Create account

// Create virtualenv & web app

// Test manually that Django works

// Step 3: Add a GitHub Actions workflow

// Create folder: .github/workflows

// Add a file: django-ci-cd.yml

// Paste the example I shared earlier (with PythonAnywhere deploy)

// Step 4: Add secrets to GitHub

// PA_HOST → ssh.pythonanywhere.com

// PA_USER → your username

// PA_KEY → your private SSH key (from your computer)

// Step 5: Push code to GitHub

// GitHub Actions automatically triggers

// First run will test and deploy

// Step 6: Debug & improve

// Check workflow logs on GitHub

// Make changes if tests fail or deploy fails

// 4️⃣ Recommended Tutorials
// a) Git + GitHub

// Git & GitHub Crash Course for Beginners – freeCodeCamp

// b) Django Deployment Basics

// Deploy Django on PythonAnywhere – official tutorial

// c) GitHub Actions (CI/CD)

// GitHub Actions Tutorial for Beginners – freeCodeCamp

// Official GitHub Actions Docs

// d) Python Testing & Linting

// pytest: https://docs.pytest.org/en/stable/getting-started.html

// flake8: https://flake8.pycqa.org/en/latest/

// 5️⃣ Suggested Learning Path

// Learn Git basics → push code to GitHub

// Learn Django basics → run server, create virtualenv, migrate DB

// Learn pytest & flake8 → write simple tests and lint code

// Learn SSH basics → connect to PythonAnywhere console

// Learn GitHub Actions basics → write a simple workflow that runs tests

// Combine → create full CI/CD: test → deploy
