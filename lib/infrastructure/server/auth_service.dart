import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:chat/infrastructure/entities/user_entity.dart';
import 'package:chat/infrastructure/models/user_model.dart';
import 'package:chat/infrastructure/wrapper/user_wrapper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserWrapper _userWrapper = UserWrapper();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<UserModel> get authStateChanges => _auth.authStateChanges().map(
    (_firebaseUser) => _firebaseUser != null ? _getUserModelByFirebaseUser(_firebaseUser) : null
  );

  Future<UserModel> currentUser() async {
    try {
      User _firebaseUser = _auth.currentUser;
      await _firebaseUser?.getIdToken();

      return _firebaseUser != null
          ? Future<UserModel>.value(_getUserModelByFirebaseUser(_firebaseUser))
          : Future<UserModel>.value(null);
    } on FirebaseAuthException catch (e) {
      print(e?.code);
      print(e?.message);
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider _googleProvider = GoogleAuthProvider();
        await _auth.setPersistence(Persistence.NONE);
        UserCredential _userCredential = await _auth.signInWithPopup(_googleProvider);
        return _getUserModelByCredential(_userCredential);
      } else {
        final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
        final AuthCredential _googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken,
          idToken: _googleAuth.idToken,
        );
        UserCredential _userCredential = await _auth.signInWithCredential(_googleAuthCredential);
        UserModel _user = _getUserModelByCredential(_userCredential);
        return _user;
      }
    }
    catch (e) {
      print(e?.code);
      print(e?.message);
    }
  }

  Future<void> signout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  UserModel _getUserModelByCredential(UserCredential userCredential) => _userWrapper.toModel(
    _firebaseUser2entity(userCredential.user)
  );

  UserModel _getUserModelByFirebaseUser(User firebaseUser) => _userWrapper.toModel(
    _firebaseUser2entity(firebaseUser)
  );

  UserEntity _firebaseUser2entity(User firebaseUser) => UserEntity(
    userId: firebaseUser.uid,
    userName: firebaseUser.displayName,
    email: firebaseUser.email,
    photoUrl: firebaseUser.photoURL,
  );
}
