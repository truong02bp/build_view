import 'package:chat_application/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    User? user;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("accessToken", googleSignInAuthentication.accessToken!);
      prefs.setString("idToken", googleSignInAuthentication.idToken!);
      user = await getUser(googleSignInAuthentication.accessToken!,
          googleSignInAuthentication.idToken!);
    }
    return user;
  }

  Future<User?> signInWithEmailPassword(
      {required String email, required String password}) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = credential.user;
    if (firebaseUser != null) {
      final QuerySnapshot result = await firestore
          .collection(FirestoreConstants.pathUserCollection)
          .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
          .get();
      final document = result.docs;
      if (document.isEmpty) {
        firestore
            .collection(FirestoreConstants.pathUserCollection)
            .doc(firebaseUser.uid)
            .set({
          FirestoreConstants.id: firebaseUser.uid,
          FirestoreConstants.avatar: firebaseUser.photoURL,
          FirestoreConstants.username: firebaseUser.email,
        });
      }
    }
    return firebaseUser;
  }

  Future<User?> getUser(String accessToken, String idToken) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    final firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      final QuerySnapshot result = await firestore
          .collection(FirestoreConstants.pathUserCollection)
          .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
          .get();
      final document = result.docs;
      if (document.isEmpty) {
        firestore
            .collection(FirestoreConstants.pathUserCollection)
            .doc(firebaseUser.uid)
            .set({
          FirestoreConstants.id: firebaseUser.uid,
          FirestoreConstants.avatar: firebaseUser.photoURL,
          FirestoreConstants.username: firebaseUser.email,
        });
      }
    }
    return firebaseUser;
  }

  Future<void> signOut() async {
    await fireAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}
