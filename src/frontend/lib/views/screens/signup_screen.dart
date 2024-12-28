import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/utils/app_text_style.dart';
import 'package:FatCat/viewmodels/sigup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
      child: Consumer<SignupViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundScreen,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundScreen,
              elevation: 0,
              title: Text("Đăng Ký", style: AppTextStyles.boldText28),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Chào mừng bạn đến với FatCat!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Vui lòng điền thông tin để tạo tài khoản.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 40),
                  _buildTextField("Tên người dùng", Icons.person,
                      viewModel.usernameController),
                  SizedBox(height: 16),
                  _buildTextField(
                      "Email", Icons.email, viewModel.emailController),
                  SizedBox(height: 16),
                  _buildTextField(
                      "Mật khẩu",
                      Icons.lock,
                      isPassword: true,
                      viewModel.passwordController),
                  SizedBox(height: 16),
                  _buildTextField("Xác nhận mật khẩu", Icons.lock,
                      viewModel.confirmPasswordController,
                      isPassword: true),
                  SizedBox(height: 24),
                  Center(
                    child: viewModel.isLoading // Check loading state
                        ? CircularProgressIndicator(
                            color: Colors.black54,
                          ) // Show loading spinner
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (viewModel.validateInput() == null) {
                                  viewModel.signup(context);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: viewModel.validateInput()!,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.backgroundButtonColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                "Đăng Ký",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Đã có tài khoản? Đăng nhập ngay!",
                        style: TextStyle(
                          color: AppColors.blackText,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.blackText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.blackText),
        ),
      ),
    );
  }
}
