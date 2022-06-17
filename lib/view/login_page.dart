import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_dot_technical_app/helper/count_lower_upper_case.dart';
import 'package:test_dot_technical_app/helper/email_validator.dart';
import 'package:test_dot_technical_app/helper/simple_alert_dialog.dart';
import 'package:test_dot_technical_app/view/home_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final CountLowerUpperCase _countLowerUpperCase = CountLowerUpperCase();
  final EmailValidator _emailValidator = EmailValidator();

  final ValueNotifier<bool> _validTextEmail = ValueNotifier(false);
  final ValueNotifier<bool> _validTextPassword = ValueNotifier(false);

  bool _checkValidationTextEmail(String email) {
    if (_emailValidator.check(email)) {
      _validTextEmail.value = true;
      return true;
    } else {
      _validTextEmail.value = false;
      return false;
    }
  }

  bool _checkValidationTextPassword(String password) {
    if (_countLowerUpperCase.check(_passwordController.text) &&
        password.length >= 6) {
      _validTextPassword.value = true;
      return true;
    } else {
      _validTextPassword.value = false;
      return false;
    }
  }

  void _validation() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      SimpleAlertDialog.showSimpleAlertDialog(
          context, 'Text input tidak boleh kosong');
    } else {
      if (_checkValidationTextEmail(_emailController.text) &&
          _checkValidationTextPassword(_passwordController.text)) {
        _loginProcess();
      }
    }
  }

  void _loginProcess() {
    _countLowerUpperCase.check(_passwordController.text);
    _isLoading.value = true;
    Timer(const Duration(seconds: 3), () {
      _isLoading.value = false;
      Navigator.pushNamed(context, HomePage.routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    _validTextEmail.value = true;
    _validTextPassword.value = true;
  }

  @override
  void dispose() {
    super.dispose();
    _isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'LOGIN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _checkValidationTextEmail(value);
                  } else {
                    _validTextEmail.value = true;
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1))),
              ),
              ValueListenableBuilder(
                  valueListenable: _validTextEmail,
                  builder: (context, bool value, _) {
                    if (value) {
                      return Container();
                    } else {
                      return Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Email tidak valid',
                          style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.red),
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _passwordController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _checkValidationTextPassword(value);
                  } else {
                    _validTextPassword.value = true;
                  }
                },
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1)),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: _validTextPassword,
                  builder: (context, bool value, _) {
                    if (value) {
                      return Container();
                    } else {
                      return Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Harus terdapat 1 huruf besar dan 1 huruf kecil serta minimal 6 karakter',
                          style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.red),
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.transparent,
                child: ValueListenableBuilder(
                    valueListenable: _isLoading,
                    builder: (context, bool value, _) {
                      if (value) {
                        return ElevatedButton(
                            onPressed: () {},
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )));
                      } else {
                        return ElevatedButton(
                            onPressed: () {
                              _validation();
                            },
                            child: const Text('Submit'));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
