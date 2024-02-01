import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/views/screens/auth/signup_screen.dart';
import 'package:tiktok_flutter/views/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigateToSignup() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tiktok Clone',
              style: TextStyle(
                color: buttonColor,
                fontSize: 35,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              width: MediaQuery.of(context).size.width,
              child: TextInputField(
                labelText: 'Email',
                controller: _emailController,
                icon: const Icon(Icons.email),
                isObscure: false,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextInputField(
                labelText: 'Password',
                controller: _passwordController,
                icon: const Icon(Icons.password),
                isObscure: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: () => authController.loginUser(
                  _emailController.text,
                  _passwordController.text,
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  // バックスラッシュで点があってもシングルクォーテーションで書ける
                  'Don\'t have an account?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: navigateToSignup,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
