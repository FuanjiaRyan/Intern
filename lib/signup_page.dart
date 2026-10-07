import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:third_app/welcome_page.dart';

import 'auth_service.dart';
import 'login_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //Username
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter Username",
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Username";
                  }
                },
              ),
              SizedBox(height: 10),
              //Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  if (!value.contains("@")) {
                    return "Enter a valid email";
                  }
                },
              ),
              SizedBox(height: 10),
              //Password
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                },
              ),
              SizedBox(height: 10),
              //Confirm Password
              TextFormField(
                controller: _confirmPwController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  labelText: "password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }
                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                },
              ),
              SizedBox(height: 10),

              //Login screen button
              TextButton(
                onPressed: () async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("Already have an account? Login"),
              ),

              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {

                    try {
                      final user = await authService.signUp(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        username: _nameController.text.trim(),
                      );

                      if (user != null && context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePage()
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sign Up Failed: ${e.message}"),
                          ),
                        );
                      }
                    }

                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
