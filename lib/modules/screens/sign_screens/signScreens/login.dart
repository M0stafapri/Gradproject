import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simpleui/modules/screens/sign_screens/signScreens/register.dart';
import 'package:simpleui/modules/widgets/snackBar_widget.dart';
import 'package:simpleui/shared/style/colors.dart';
import '../../../../layout/layout_screen.dart';
import '../../../widgets/alert_dialog_widget.dart';
import '../../../widgets/buttons_widget.dart';
import '../cubit/signCubit.dart';
import '../cubit/signStates.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Widget buttonsWidget({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit, SignStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeLayoutScreen()),
          );
        }
        if (state is UserLoginErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarWidget(
              message: state.error.toString(),
              context: context,
              color: Colors.red,
            ),
          );
        }
        if (state is UserLoginLoadingState) {
          showAlertDialog(
            context: context,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: mainColor,
                  strokeWidth: 3,
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = SignCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 0.35.sh,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "MyFitnessPal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (val) {
                              return val?.trim().isEmpty ?? true
                                  ? "Please enter your email address"
                                  : null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Enter your email address",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            obscureText: true,
                            validator: (val) {
                              return val?.trim().isEmpty ?? true
                                  ? "Please enter your password"
                                  : null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Enter your password",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          if (state is! UserLoginLoadingState)
                            buttonsWidget(
                              text: "Login",
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  cubit.userLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                            ),
                          if (state is UserLoginLoadingState)
                            Center(
                              child: CircularProgressIndicator(
                                color: mainColor,
                                strokeWidth: 3,
                              ),
                            ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
