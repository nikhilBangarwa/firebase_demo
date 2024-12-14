import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<User?> register(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    return user;
  }

  Future <User?>login(String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
   return  userCredential.user;

  }

}
