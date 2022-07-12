import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_health_tracker_app/models/user.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser? _userFromFirebaseUser(User? user) {
    return user!=null ? CustomUser(uid: user.uid) : null;
  }

  Stream<CustomUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  Future signInAnnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
}
}