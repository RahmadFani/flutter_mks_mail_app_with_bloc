import 'package:flutter/material.dart';
import 'package:flutter_application_test/repositories/authentication_repository.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController username;
  late TextEditingController password;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void onLoginPress() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (loading) return;

    try {
      setState(() {
        loading = true;
      });
      await context
          .read<AuthenticationRepository>()
          .login(username: username.text, password: password.text);
    } catch (e) {
      context.showErrorSnackBar(message: 'Username / Password tidak ditemukan');
      Get.log('ERROR ${e.toString()}');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void onForgotPasswordPress() async {
    if (loading) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: titleText,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Please sign in to continue.',
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: username,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  label: const Text('USERNAME'),
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              onEditingComplete: () => onLoginPress(),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  label: const Text('PASSWORD'),
                  labelStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: onLoginPress,
                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ))),
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                '@MultiKaryaSolusi - 2021',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

TextStyle titleText =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
