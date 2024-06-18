import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("L'utilisateur a annulé la connexion");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Redirige vers la page d'accueil ou une autre page
      Navigator.popAndPushNamed(context, "/home");
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue,
      child: InkWell(
        onTap: () => _googleSignIn(context),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/google.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          const Text(
            'Sign in with Google',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ]),
      ),
    );
  }
}
