
import 'package:firebase_demo/auth/provider/auth_provider.dart';
import 'package:firebase_demo/core/app_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class SighUpScreen extends StatefulWidget {
  const SighUpScreen({super.key});

  @override
  State<SighUpScreen> createState() => _SighUpScreenState();
}

class _SighUpScreenState extends State<SighUpScreen> {
  final key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Sign Up Screen"),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: key,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextFormField(_emailController,'Username or email'),
                _buildSizedBox(10),

                _buildTextFormField(_passwordController,'User password'),

                _buildSizedBox(15),
                ElevatedButton(onPressed: _sighUp, child: const Text('Sigh Up'))
              ],
            ),
          )),
    );
  }

  SizedBox _buildSizedBox(double height) {
    return  SizedBox(
      height: height,
    );
  }

  Widget _buildTextFormField(controller,String title,) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.blue),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: title,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12), // Smaller hint text
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
            ),
            height: 20,
            child: const Icon(
              Icons.account_circle,
              color: Colors.blue, // Icon color
            ),
          ),
        ),
      ),
    );
  }

  Future _sighUp()async {
    String email = _emailController.text;
    String password = _passwordController.text;
 if(email.isNotEmpty&&password.isNotEmpty){
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
   await authProvider.register(email, password);
   if (authProvider.error == null) {
     if (mounted) {
       AppUtils.appUtil('Your account is create successfully');
       Navigator.pop(context);
     }
   }
   else{
     if(mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: (Text("Your password is Not match"))));

     }
   }

 }
  }

}