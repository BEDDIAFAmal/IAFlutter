import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:activity_beddiaf/ajouterForm.dart';
import 'package:activity_beddiaf/listActivite.dart';
import 'package:activity_beddiaf/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Activity'),
      ),
      body: Container(
        color: Colors.pinkAccent[400],
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 100,
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email address.' : null,
                onSaved: (value) => setState(() => _email = value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password.' : null,
                onSaved: (value) => setState(() => _password = value!),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      // Sign in with email and password
                      await _firebaseAuth.signInWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );

                      // Navigate to ListeActivite on successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListeActivite(), // Passer votre liste d'activités ici
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      // If sign in fails, display a message to the user.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message!),
                        ),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 50))),
                child: const Text('Se connecter'),
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
