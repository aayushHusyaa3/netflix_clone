import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ModelClass/profile_model.dart';
import 'package:flutter_application_2/app/api/api_helpers.dart';
import 'package:flutter_application_2/app/api/api_path.dart';

import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio dio = Dio();
  ProfileModel? profileModel;
  TextEditingController? nameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passController = TextEditingController();
  TextEditingController? ageController = TextEditingController();
  String? error;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProfileInfo(context);
  }

  Future<void> logut(context) async {
    final token = await storage.read(key: "token");
    try {
      final Response response = await dio.post(
        ApiPath.baseUrl + ApiPath.logOut,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        myAlertBox(context, titleText: "Logout Succesful");
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, AppRoutes.login);
        });
      }
    } on DioError catch (exe) {
      throw Exception(exe);
    }
  }

  Future<void> getProfileInfo(context) async {
    final token = await storage.read(key: "token");

    try {
      final Response response = await dio.get(
        ApiPath.baseUrl + ApiPath.profileUrl,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      setState(() {
        profileModel = ProfileModel.fromJson(response.data);
        emailController!.text = profileModel!.data?.email! ?? "No email";
        nameController!.text = profileModel!.data?.name! ?? "No Name";
        passController!.text = "**********";
        ageController!.text =
            profileModel!.data?.age.toString() ?? "Not provided";
        isLoading = false;
      });
    } on DioError catch (exe) {
      setState(() {
        error = exe.message!;
      });
    }
  }

  Future<void> editDetails() async {
    final token = await storage.read(key: "token");
    try {
      final response = await dio.post(
        "http://192.168.1.212:8000/api/profile-edit",
        data: {
          "email": emailController!.text.trim(),
          "name": nameController!.text.trim(),
          "age": int.tryParse(ageController!.text),
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (!mounted) return;
      if (response.statusCode == 200) {
        setState(() {
          getProfileInfo(context);
        });
        log("Profile updated successfully");
        mySnackBar(context, snackBarText: "Profile updated successfully");
      }
    } on DioError catch (exe) {
      log("Edit error: ${exe.message}");
      mySnackBar(context, snackBarText: "Update failed: ${exe.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileDetail = profileModel;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!, style: t4()))
              : profileModel == null || profileDetail == null
                  ? Center(child: Text("No Profile Found"))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 20.w,
                            ),
                            child: Row(
                              children: [
                                Text("Your Profile", style: t4()),
                                Spacer(),
                                Icon(Icons.settings),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(15.w),
                              child: Column(
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/photo.png"),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    profileDetail.data!.name!,
                                    style: t4().copyWith(
                                      color: Colors.purple,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    profileDetail.data!.email ?? "asdad",
                                    style: t4().copyWith(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  MyTextField(
                                    controller: nameController!,
                                    headingText: "Name",
                                    textColor: Colors.black,
                                    icon: Icons.contact_page,
                                  ),
                                  MyTextField(
                                    controller: emailController!,
                                    headingText: "Email",
                                    textColor: Colors.black,
                                    icon: Icons.email,
                                  ),
                                  MyTextField(
                                    controller: ageController!,
                                    headingText: "Age",
                                    textColor: Colors.black,
                                    icon: Icons.person,
                                  ),
                                  MyTextField(
                                    controller: passController!,
                                    headingText: "Password",
                                    textColor: Colors.black,
                                    isEnable: false,
                                    icon: Icons.lock,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyElevatedButton(
                                        text: "Save",
                                        onPressed: () {
                                          editDetails();
                                        },
                                        isFulled: false,
                                      ),
                                      MyElevatedButton(
                                        text: "Reset",
                                        onPressed: () {
                                          getProfileInfo(context);
                                          mySnackBar(
                                            context,
                                            snackBarText:
                                                "Profile Reset Successfully",
                                          );
                                        },
                                        isFulled: false,
                                      ),
                                      MyElevatedButton(
                                        text: "log out",
                                        onPressed: () {
                                          logut(context);
                                        },
                                        isFulled: false,
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
    );
  }
}
