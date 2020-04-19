import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String name;
  String email;
  String imageUrl;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    this.name = user.displayName;
    this.email = user.email;
    this.imageUrl = user.photoUrl;

    // Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      this.name = name.substring(0, name.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    this.name = user.displayName;
    this.email = user.email;
    this.imageUrl = user.photoUrl;
    return user;
  }

  Future<String> getName() async {
    if (this.name == null) {
      FirebaseUser _user = await this.getCurrentUser();
      this.name = _user.displayName;
      this.email = _user.email;
      this.imageUrl = _user.photoUrl;
    }
    return this.name;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}

