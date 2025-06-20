import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/AppColor/app_color.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';
import 'package:flutter_application_2/cubit/cubit/loginn_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginCubit>();
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.r, horizontal: 25.r),
        child: Center(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.logginIn) {
                mySnackBar(context, snackBarText: state.error);
                bloc.clearMessage();
              } else if (state.status == LoginStatus.emptyInfo) {
                mySnackBar(context, snackBarText: state.error);
                bloc.clearMessage();
              } else if (state.status == LoginStatus.loggedIn) {
                mySnackBar(context, snackBarText: state.error);
                bloc.clearMessage();
                Navigator.pushNamed(context, AppRoutes.home);
              } else if (state.status == LoginStatus.loginFailure) {
                mySnackBar(context, snackBarText: state.error);
                bloc.clearMessage();
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Text("Movies Hunt", style: t1()),
                  Text(
                    "Millions of Songs for Free & Without Ads",
                    style: t2(),
                  ),
                  SizedBox(height: 30.h),
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
                              icon: Icons.email,
                            ),
                            MyTextField(
                              controller: passwordController,
                              isHide: true,
                              headingText: "Password",
                              hintText: "**********",
                              icon: Icons.lock,
                            ),
                            MyElevatedButton(
                              text: "Login",
                              onPressed: () {
                                String myEmail =
                                    emailController.text.toString();
                                String myPassword =
                                    passwordController.text.toString();

                                context.read<LoginCubit>().loginCubit(
                                    email: myEmail,
                                    password: myPassword,
                                    context: context);
                              },
                            ),
                            Row(
                              children: [
                                Text("Remember Me", style: t3()),
                                Spacer(),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Forget Password?",
                                    style: t3(),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "---------------------------------OR---------------------------------",
                              style: t3(),
                            ),
                            SizedBox(height: 30.h),
                            Row(
                              children: [
                                iConContainer(
                                  icon: FontAwesomeIcons.facebook,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 7.w),
                                iConContainer(
                                  icon: FontAwesomeIcons.google,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.register,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an Account?", style: t3()),
                                  Text(
                                    " Sign Up",
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
              );
            },
          ),
        ),
      ),
    ));
  }
}
