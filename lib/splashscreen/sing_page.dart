import 'package:adkar_flutter/splashscreen/googleBouton.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final FirebaseAuth authInstance = FirebaseAuth.instance;

  bool _validateInputs() {
    if (_fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Full name is required')),
      );
      return false;
    }
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valid email is required')),
      );
      return false;
    }
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return false;
    }
    return true;
  }

  void _signUp() async {
    if (!_validateInputs()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await authInstance.createUserWithEmailAndPassword(
        email: _emailController.text.toLowerCase().trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User created successfully')),
      );
      _fullNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      Navigator.popAndPushNamed(context, "/home");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User creation error: $error')),
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
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: _isLoading
                  ? const SpinKitFadingCircle(
                      size: 60,
                      color: Colors.white,
                    )
                  : Container(
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
                                        speed:
                                            const Duration(milliseconds: 1000),
                                      ),
                                      TypewriterAnimatedText(
                                        'Design first, then code',
                                        speed:
                                            const Duration(milliseconds: 1000),
                                      ),
                                      TypewriterAnimatedText(
                                        'Do not patch bugs out, rewrite them',
                                        speed:
                                            const Duration(milliseconds: 1000),
                                      ),
                                      TypewriterAnimatedText(
                                        'Do not test bugs out, design them out',
                                        speed:
                                            const Duration(milliseconds: 1000),
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
                          _buildSignUpForm(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextField(
          controller: _fullNameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 10),
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
            onPressed: () {},
            child: const Text(
              'Forget password?',
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _signUp,
          child: const Text('Sign up'),
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
            SizedBox(width: 5),
            Text(
              'GO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Divider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: 'Don\'t have an account?',
            style: const TextStyle(color: Colors.white, fontSize: 18),
            children: [
              TextSpan(
                text: '  Sign in',
                style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.popAndPushNamed(context, "/");
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
