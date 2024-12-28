import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  bool _otpSent = false; // State to track if OTP is sent

  void _showToast(String message, {Color backgroundColor = Colors.green}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 338,
              height: 40,
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 33,
                  fontFamily: 'Yu Gothic UI',
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.22,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 274,
              height: 50,
              child: Text(
                'Enter your email address and we will send you a reset instructions.',
                style: TextStyle(
                  color: Color(0xFF868686),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.40,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "EMAIL",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextField(
                  style: const TextStyle(fontSize: 18),
                  controller: _emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundButtonColor,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() => _isLoading = true);
                        try {
                          bool rs = await AuthService.forgotPassword(
                            _emailController.text.trim(),
                          );
                          if (rs) {
                            _showToast(
                              "Mật khẩu đã được gửi về mail của bạn",
                              backgroundColor: Colors.green,
                            );
                          } else {
                            _showToast(
                              "Kiểm tra kết nối mạng của bạn",
                              backgroundColor: Colors.green,
                            );
                          }
                        } catch (error) {
                          _showToast(
                            "Failed to send. Try again.",
                            backgroundColor: Colors.red,
                          );
                        } finally {
                          setState(() => _isLoading = false);
                        }
                      },
                child: const Text('XÁC THỰC'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
