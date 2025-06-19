import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/AppColor/app_color.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.r, horizontal: 25.r),
        child: Center(
          child: Column(
            children: [
              Text("Register", style: t1()),

              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 12,
                  shadowColor: Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.all(25.r),
                    child: Column(
                      children: [
                        MyTextField(
                          controller: nameController,
                          headingText: "Full Name",
                          hintText: "Aayush Gupta",
                        ),
                        MyTextField(
                          controller: emailController,
                          headingText: "Email",
                          hintText: "aayush3@gmail.com",
                        ),
                        MyTextField(
                          controller: passwordController,
                          headingText: "Password",
                          hintText: "**************",
                          isHide: true,
                        ),
                        MyTextField(
                          controller: confirmPassController,
                          headingText: "Confirm Password",
                          hintText: "***********",
                          isHide: true,
                        ),

                        MyElevatedButton(text: "Register", onPressed: () {}),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?", style: t3()),
                              Text(
                                " Login",
                                style: t3().copyWith(
                                  color: AppColor.headingColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
