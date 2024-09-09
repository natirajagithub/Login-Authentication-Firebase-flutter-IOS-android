import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/src/features/Auth/screens/passwordReset.dart';
import 'package:login_app/src/features/Auth/screens/verification-code.dart';

class PhoneRecoveryScreen extends StatefulWidget {
  @override
  _PhoneRecoveryScreenState createState() => _PhoneRecoveryScreenState();
}

class _PhoneRecoveryScreenState extends State<PhoneRecoveryScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isSendingOTP = false; // Track if OTP is being sent
  bool showOTPField = false; // Track if OTP field should be displayed

  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Phone Recovery', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF64B5F6), // Light Blue
              Color(0xFF1976D2), // Dark Blue
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPhoneField(),
                SizedBox(height: 20),
                if (showOTPField) ...[
                  _buildOTPField(),
                  SizedBox(height: 20),
                  _buildVerifyOTPButton(),
                ] else ...[
                  _buildGenerateOTPButton(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "Enter Phone Number",
        prefixIcon: Icon(Icons.phone),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildGenerateOTPButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: isSendingOTP ? null : () async {
        setState(() {
          isSendingOTP = true;
        });

        String phoneNumber = "+91${phoneController.text.trim()}"; // Adjust country code as needed

        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) {
              // This callback will be triggered automatically in some situations,
              // for example, if the phone number is instantly verified without needing to send an OTP.
              print("Instant verification");
              FirebaseAuth.instance.signInWithCredential(credential);
              setState(() {
                showOTPField = true;
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              print(e.message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Verification failed. Please try again.'),
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {
                isSendingOTP = false;
              });
            },
            codeSent: (String verificationId, int? resendToken) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('OTP has been sent'),
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {
                this.verificationId = verificationId;
                showOTPField = true;
                isSendingOTP = false;
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              // Timeout waiting for auto-retrieval of OTP
              setState(() {
                this.verificationId = verificationId;
              });
            },
          );
        } catch (e) {
          print("Error sending OTP: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error sending OTP. Please try again.'),
              duration: Duration(seconds: 2),
            ),
          );
          setState(() {
            isSendingOTP = false;
          });
        }
      },
      child: Text(
        isSendingOTP ? "Sending OTP..." : "Generate OTP",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildOTPField() {
    return TextField(
      controller: otpController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Enter OTP",
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildVerifyOTPButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () async {
        String otp = otpController.text.trim();
        if (otp.length != 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please enter a valid OTP'),
              duration: Duration(seconds: 1),
            ),
          );
          return;
        }

        try {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: otp,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);
          // Verification successful, navigate to next screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PasswordResetScreen()), // Replace with your desired screen
          );
        } catch (e) {
          print("Error verifying OTP: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid OTP. Please try again.'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Text(
        "Verify OTP",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
