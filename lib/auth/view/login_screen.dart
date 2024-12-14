
import 'package:firebase_demo/auth/provider/auth_provider.dart';
import 'package:firebase_demo/auth/view/Sigh_Up_Screen.dart';
import 'package:firebase_demo/core/app_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isTrue = false;
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login Screen",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        body: _customBody()
    );
  }

  Widget _customBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: key,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login Account ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.blue),
                  )
                ],
              ),
              _sizedBox(16),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.blue),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Username or email',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      height: 20,
                      child: const Icon(
                        Icons.account_circle,
                        color: Colors.blue, // Icon color
                      ),
                    ),
                  ),
                ),
              ),
              _sizedBox(20),
              _buildTextFormField(),
              _sizedBox(20),
              Row(
                children: [
                  Checkbox(
                      value: isTrue,
                      onChanged: (value) {
                        setState(() {
                          isTrue = value!;
                        });
                      }),
                  const Text('Remember me'),
                  const SizedBox(
                    width: 220,
                  ),
                  TextButton(onPressed: _login, child: const Text("Login"))

                ],
              ),
              _sizedBox(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SighUpScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Create a new account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      )),
                ],
              ),
              _sizedBox(16),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _sizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      obscureText: searching ? false : true,
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.blue),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'password',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              height: 20,
              width: 20,
              child: const Icon(
                Icons.key,
                color: Colors.blue,
              ),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                searching = !searching;
              });
            },
            icon: searching
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off_outlined),
          )),
    );
  }

  Future _login() async {
    String email = emailController.text;
    String password = passwordController.text;
   if(email.isNotEmpty&&password.isNotEmpty){
     final authProvider = Provider.of<AuthProvider>(context, listen: false);
     await authProvider.login(email, password);
     if (authProvider.error == null) {
       AppUtils.appUtil('Your Account is login successfully');

     } else {
       print('your email ya password is not match');
     }
   }
  }

}
