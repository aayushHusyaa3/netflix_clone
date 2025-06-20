import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.r, horizontal: 25.r),
        child: Center(
          child: Column(
            children: [
              Text("Forget Password", style: t1()),

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
                          controller: emailController,
                          headingText: "Email",
                          hintText: "aayush3@gmail.com",
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
