import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/pages/homepage.dart';
import 'package:women_safety/pages/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText: 'Full Name',
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty
                                            ? 'Please enter your name'
                                            : null,
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText: 'Email',
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText: 'Password',
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                obscureText: true,
                                validator:
                                    (value) =>
                                        (value == null || value.length < 6)
                                            ? 'Password must be at least 6 characters'
                                            : null,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          height: 50,
                          width: 240,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: _signUp,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed:
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              ),
                          child: Text(
                            "Back to Login",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
