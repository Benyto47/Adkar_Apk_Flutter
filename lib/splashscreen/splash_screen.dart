import 'dart:async';
import 'package:adkar_flutter/splashscreen/googleBouton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final FirebaseAuth authInstance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to check user status after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkCurrentUser();
    });
  }

  void _checkCurrentUser() async {
    User? user = authInstance.currentUser;
    if (user != null) {
      Navigator.popAndPushNamed(context, "/home");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valid email is required')),
      );
      return;
    }
    if (password.isEmpty || password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
      Navigator.popAndPushNamed(context, "/home");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashbg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 250.0,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Agne',
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                "startTitle".tr,
                                speed: const Duration(milliseconds: 1000),
                              ),
                              TypewriterAnimatedText(
                                'Design first, then code',
                                speed: const Duration(milliseconds: 1000),
                              ),
                              TypewriterAnimatedText(
                                'Do not patch bugs out, rewrite them',
                                speed: const Duration(milliseconds: 1000),
                              ),
                              TypewriterAnimatedText(
                                'Do not test bugs out, design them out',
                                speed: const Duration(milliseconds: 1000),
                              ),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildLoginForm(),
                  const SizedBox(height: 100),
                  if (_isLoading)
                    const SpinKitFadingCircle(
                      size: 60,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              // Logic for forget password can be added here
            },
            child: const Text(
              'Forget password?',
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: const Text('Login'),
        ),
        const SizedBox(height: 10),
        const GoogleButton(),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'GO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Divider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            text: 'Don\'t have an account?',
            style: const TextStyle(color: Colors.white, fontSize: 18),
            children: [
              TextSpan(
                text: '  Sign up',
                style: const TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.popAndPushNamed(context, "/sing");
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
