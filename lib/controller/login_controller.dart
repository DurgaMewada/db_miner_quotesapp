import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var emailError = ''.obs;
  var passwordError = ''.obs;

  bool validateEmail() {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emailError.value = 'Enter a valid email';
      return false;
    } else {
      emailError.value = '';
      return true;
    }
  }

  bool validatePassword() {
    String password = passwordController.text.trim();
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      return false;
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return false;
    } else {
      passwordError.value = '';
      return true;
    }
  }

  bool validateForm() {
    return validateEmail() & validatePassword();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}