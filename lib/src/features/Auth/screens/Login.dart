import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/src/features/Auth/screens/phone-recovery.dart';
import 'package:login_app/src/features/Auth/screens/email-recovery.dart';
import 'package:login_app/src/features/Auth/screens/sign-up.dart';
import 'googlelogin.dart';
import 'home.dart'; // Assuming Firebase services are implemented here

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordHidden = true; // Flag to track password visibility
  FirebaseServices firebaseServices = FirebaseServices();





  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ForgotPasswordDialog(
          _handleRecoveryMethod,
        );
      },
    );
  }

  void _handleRecoveryMethod(BuildContext context, String method) {
    Navigator.pop(context); // Close previous dialog
    if (method == 'email') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmailRecoveryScreen()),
      );
    } else if (method == 'phone') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PhoneRecoveryScreen()),
      );
    }
  }



  void _signInWithEmailAndPassword(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Clear text fields after successful login
      emailController.clear();
      passwordController.clear();

      // Navigate to the home screen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      print('User logged in: ${userCredential.user!.uid}');
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to sign in. Please check your credentials and try again.'),
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

      print('Failed to sign in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.list, color: Colors.white),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
        title: Center(
          child: Text('User Login', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/images/ab.png',
                  height: 95, // Adjust the height as needed
                ),
                SizedBox(height: 16.0),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Please log in with your email and password or recover your password.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: passwordController,
                  obscureText: _isPasswordHidden,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 202),
                  child: TextButton(
                    onPressed: () {
                      _showForgotPasswordDialog(context);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _signInWithEmailAndPassword(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'or',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await firebaseServices;
                      // Navigate to the next screen after successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content:
                            Text('Failed to sign in with Google. Please try again.'),
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
                  icon: Icon(Icons.g_translate),
                  label: Text('Login with Google'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                ),
                SizedBox(height: 12.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
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

class ForgotPasswordDialog extends StatelessWidget {
  final Function(BuildContext, String) handleRecoveryMethod;

  ForgotPasswordDialog(this.handleRecoveryMethod);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Forgot Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            onTap: () {
              handleRecoveryMethod(context, 'email');
            },
          ),
          ListTile(
            leading: Icon(Icons.mobile_friendly_rounded),
            title: Text('Phone'),
            onTap: () {
              handleRecoveryMethod(context, 'phone');
            },
          ),
        ],
      ),
    );
  }
}
