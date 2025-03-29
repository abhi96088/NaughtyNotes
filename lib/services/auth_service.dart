import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  // create instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  getInstance() => _auth;

  ///^^^^^^^^^^^^^^^^ Function to handle signIn ^^^^^^^^^^^^^^///
  Future<User?> signInWithGoogle() async{

    try{
      // popup google signing dialogue
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null) return null; // return if cancelled
      // get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // create firebase authentication credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,  // access token is a temporary key provided by google
        idToken: googleAuth.idToken   // id token contains user identity information (email, name, dp, etc)
      );

      // signIn to firebase with google credentials
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user; // return authenticated firebase user
    } catch(e){
      print("Error Signing With Google: $e");
      return null;
    }
  }

  ///^^^^^^^^^^^^^ Function to handle logOut ^^^^^^^^^^^^^^^^^^^///
  Future<void> signOut() async{
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}