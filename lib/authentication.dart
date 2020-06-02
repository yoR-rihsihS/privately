import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthImplementation {
  Future<String> signInWithGoogle();
  Future<String> getCurrentUser();
  void signOutGoogle();
}

class Auth implements AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await _googleSignInAccount.authentication;
    final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult _authResult =
        await _firebaseAuth.signInWithCredential(_authCredential);
    final FirebaseUser _user = _authResult.user;

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(_user.uid == currentUser.uid);

    print(_user.uid);
    return _user.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    return _user.uid;
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
  }
}
