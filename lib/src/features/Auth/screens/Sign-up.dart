import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign Up', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Create an Account!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  String phone = phoneController.text.trim();
                  String password = passwordController.text;

                  try {
                    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
                      throw FirebaseAuthException(message: 'Please fill in all fields', code: '');
                    }

                    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // You can store additional user information in Firebase Firestore or Realtime Database if needed
                    // For simplicity, just print the user info for now
                    print('Registered user: ${userCredential.user!.uid}');

                    // Navigate to home screen or perform other actions after successful signup
                    // Example:
                    // Navigator.pushReplacementNamed(context, '/home');
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = 'Error: ${e.message}';
                    if (e.code == 'weak-password') {
                      errorMessage = 'The password provided is too weak.';
                    } else if (e.code == 'email-already-in-use') {
                      errorMessage = 'The account already exists for that email.';
                    } else if (e.code == 'invalid-email') {
                      errorMessage = 'The email address is not valid.';
                    }
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(errorMessage),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    print('Error: $e');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('An unexpected error occurred. Please try again later.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                ),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(fontSize: 16.0, letterSpacing: 1.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
