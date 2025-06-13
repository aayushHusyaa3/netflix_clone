import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/utils/AppColor/app_color.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/providers/auth_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final String headingText;
  final bool isHide;
  final IconData? icon;
  final Color textColor;
  final TextEditingController controller;
  final bool isEnable;

  const MyTextField({
    super.key,
    this.hintText = "",
    this.headingText = "",
    this.isHide = false,
    this.icon,
    this.textColor = Colors.black,
    required this.controller,
    this.isEnable = true,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.headingText, style: t3()),
          SizedBox(height: 5.h),
          TextField(
            enabled: widget.isEnable,

            style: TextStyle(color: widget.textColor),
            controller: widget.controller,
            obscureText: widget.isHide,
            decoration: InputDecoration(
              fillColor: widget.isEnable ? Colors.white : Colors.grey.shade500,
              filled: true,
              suffixIcon: Icon(widget.icon, size: 25.r, color: Colors.purple),
              hint: Text(
                widget.hintText,
                style: t3().copyWith(color: Colors.grey.shade600),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFulled;
  const MyElevatedButton({
    super.key,
    required this.text,
    this.isFulled = true,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          width: isFulled ? double.infinity : null,

          height: 45.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.gradinet1, AppColor.gradinet2],
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: isFulled
                ? EdgeInsets.all(0)
                : EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(text, style: t4()),
          ),
        ),
      ),
    );
  }
}

Widget iConContainer({required IconData icon, Color color = Colors.red}) {
  return Expanded(
    child: Container(
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        color: AppColor.iconBgColor,
      ),

      child: Icon(icon, size: 25.h, color: color),
    ),
  );
}

void myAlertBox(BuildContext context, {String titleText = ""}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleText, style: t4()),
        actions: [
          Center(
            child: MyElevatedButton(
              text: "Okay",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );
    },
  );
}

void mySnackBar(BuildContext context, {required String snackBarText}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(snackBarText, style: t4().copyWith(color: Colors.black)),
    ),
  );
}

class MyshowButton extends StatelessWidget {
  String text;
  String userDetail;
  VoidCallback onIconPressed;
  MyshowButton({
    super.key,
    required this.text,
    required this.userDetail,
    required this.onIconPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: t3().copyWith(color: Colors.black)),
          SizedBox(height: 7.h),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              child: Row(
                children: [
                  Text(userDetail, style: t3().copyWith(color: Colors.black)),
                  Spacer(),
                  IconButton(
                    onPressed: onIconPressed,
                    icon: Icon(Icons.edit),
                    iconSize: 25.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void editDetailsAlertBox(
  BuildContext context, {
  required TextEditingController userController,
  String editDetail = "Detail",
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.r),
        ),

        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(
              controller: userController,
              headingText: editDetail,
              textColor: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: onPressed, child: Text("Save")),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
        actions: [],
      );
    },
  );
}

class MySearchTextField extends StatefulWidget {
  final String hintText;
  final Color? fillColor;
  final ValueChanged onChanged;

  final Color textColor;
  final TextEditingController controller;

  const MySearchTextField({
    required this.onChanged,
    super.key,
    this.hintText = "",

    this.fillColor,
    this.textColor = Colors.white,
    required this.controller,
  });

  @override
  State<MySearchTextField> createState() => _MySearchTextFieldState();
}

class _MySearchTextFieldState extends State<MySearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: widget.onChanged,

            style: TextStyle(color: widget.textColor),
            controller: widget.controller,
            decoration: InputDecoration(
              fillColor: AppColor.searchBgColor,
              filled: true,
              suffixIcon: Icon(Icons.mic, size: 25.r, color: Colors.grey),
              prefixIcon: Icon(Icons.search, size: 25.r, color: Colors.grey),
              hint: Text(widget.hintText, style: TextStyle(color: Colors.grey)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
