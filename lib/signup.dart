import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordObscured = true;

  // Fonction pour vérifier si l'e-mail saisi est valide et contient '@gmail.com'
  bool isEmailValid(String email) {
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email) && email.contains('@gmail.com');
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Compte créé avec succès!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Container(
        color: Colors.pink[50], // Changer la couleur de fond au rose pâle
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person), // Icône de personne pour l'e-mail
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !isEmailValid(value)) {
                    return 'Veuillez saisir une adresse e-mail valide avec @gmail.com';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordObscured,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock), // Icône de cadenas pour le mot de passe
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isPasswordObscured,
                decoration: InputDecoration(
                  labelText: 'Confirmez le mot de passe',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock), // Icône de cadenas pour la confirmation du mot de passe
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_passwordController.text == _confirmPasswordController.text) {
                      try {
                        if (_emailController.text != null && isEmailValid(_emailController.text)) {
                          await _firebaseAuth.createUserWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          _showSuccessSnackBar();

                          Navigator.pop(context); // Revenir à l'écran précédent (écran de connexion)
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Veuillez saisir une adresse e-mail valide avec @gmail.com'),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        print('Erreur lors de l\'inscription : $e');
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Les mots de passe ne correspondent pas.'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[300], // Changer la couleur du bouton au rose moyen
                ),
                child: const Text('S\'inscrire'),
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Navigate to the login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.pink[300], // Changer la couleur du texte au rose moyen
                ),
                child: const Text("Vous avez déjà un compte ? Connectez-vous"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
