
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/auth/service/auth_service.dart';
import 'package:firebase_demo/core/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AuthProvider extends ChangeNotifier {
  AuthService authService;

  AuthProvider(this.authService);

  bool isLoading = false;
  String? error;

  Future register(String email, String password) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      User? user = await authService.register(email, password);
      if(user!= null){
        AppUtils.appUtil('Sign up accounted successfully');
      }
      isLoading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      }
      AppUtils.appUtil(error.toString());
      error=e.code;
    } catch (e) {
      error = e.toString();
      AppUtils.appUtil(error.toString());
    }
    notifyListeners();
  }

  Future login(String email,String password)async{
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      User? user = await authService.login(email, password);
      if(user != null){
        AppUtils.appUtil('Login Successfully');
      }
      isLoading = false;
    } on FirebaseAuthException
    catch (e) {
      if (e.code == 'user not found') {
        error = 'No user found for thar email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }else if (e.code == 'invalid-credential') {
        error = 'invalid-credential';
      }
      AppUtils.appUtil(error.toString());
      error=e.code;
    } catch (e) {
      error = e.toString();
      AppUtils.appUtil(error.toString());
    }
    notifyListeners();
  }
}