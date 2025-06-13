import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/ModelClass/movies_model_class.dart';

import 'package:flutter_application_2/app/utils/api_helpers.dart';
import 'package:flutter_application_2/app/utils/routes/app_routes.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio dio = Dio();
  FlutterSecureStorage storage = FlutterSecureStorage();
  MovieResponseModel? movieModel;
  bool isLoading = true;
  String? errorMsg;
  @override
  void initState() {
    super.initState();
    getMoviesDetails(context);
  }

  Future<void> getMoviesDetails(context) async {
    try {
      final Response response = await dio.get(
        ApiHelpers.baseurl + ApiHelpers.homeUrl,
      );
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          movieModel = MovieResponseModel.fromJson(response.data);
        });
      }
    } on DioException catch (exe) {
      setState(() {
        isLoading = true;
        errorMsg = exe.toString();
      });

      throw Exception(exe);
    }
  }

  String? selecetdValue;
  List<String> options = ["Series", "Movies", "Categories"];
  List<String> categories = [
    'Action',
    'Hollywood',
    'Bollywood',
    'Nepali',
    'Horror',
    'Anime',
    '18+',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMsg != null
          ? Center(child: Text(errorMsg.toString()))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.r, horizontal: 20.r),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.home);
                          },
                          child: Image.asset(
                            "assets/images/movieshunt.png",
                            width: 70.w,
                            height: 70.h,
                          ),
                        ),
                        Row(
                          children: [
                            iconButton(Icons.cast),
                            iconButton(Icons.search_outlined),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        optionContainer(Text(options[0], style: t4())),
                        optionContainer(Text(options[1], style: t4())),
                        // comment Added
                        optionContainer(
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(7),
                              isDense: true,
                              isExpanded: false,
                              hint: Text("Categories", style: t4()),
                              value: selecetdValue,
                              items: categories.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selecetdValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    headingThumbnail(movieModel!.data!.data![0].thumbnailUrl!),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text("Movies", style: t1()),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text("My List", style: t4()),
                              Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 25.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 280.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movieModel!.data!.data!.length,
                        itemBuilder: (context, index) {
                          final snapshotDetail = movieModel!.data!.data![index];
                          bool onPresed = false;
                          return smallImageContainer(
                            snapshotDetail.thumbnailUrl!,
                            snapshotDetail.title!,
                            snapshotDetail.releaseDate!,
                            movieId: snapshotDetail.id,
                            istap: onPresed,
                            onIconPresed: () {
                              // setState(() {
                              //   onPresed = true;
                              // });
                            },

                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.playScreen,
                                arguments: {
                                  "title": snapshotDetail.title!,
                                  "video_url": snapshotDetail.videoUrl!,
                                  "desc": snapshotDetail.description!,
                                  "imagePath": snapshotDetail.thumbnailUrl!,
                                  "rating": snapshotDetail.rating!,
                                  "release_date": snapshotDetail.releaseDate,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget iconButton(IconData icon, {required}) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, size: 30.r, color: Colors.white),
    );
  }

  Widget optionContainer(Widget child) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1.r, color: Colors.grey),
        ),
        child: Padding(padding: EdgeInsets.all(10.r), child: child),
      ),
    );
  }

  Widget headingThumbnail(String imagePath) {
    return Container(
      width: double.infinity,
      height: 350.h,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: iconButtonWithContainer(
                icon: Icons.play_arrow,
                iconText: "Play",
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: iconButtonWithContainer(
                icon: Icons.add_outlined,
                iconText: "My List",
                iconColor: Colors.white,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconButtonWithContainer({
    Color color = Colors.white,
    required IconData icon,
    String iconText = "",
    Color iconColor = Colors.black,
  }) {
    return Container(
      height: 40.h,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: iconColor),
          Text(
            iconText,
            style: t4().copyWith(
              color: iconColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget smallImageContainer(
    String imagePath,
    String title,
    String subTitle, {
    required VoidCallback onPressed,
    bool istap = false,
    int? movieId,
    required VoidCallback onIconPresed,
  }) {
    return SizedBox(
      width: 120.w,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.r, bottom: 5.r),
            child: InkWell(
              onTap: onPressed,
              child: Container(
                alignment: Alignment.topRight,
                width: 100.w,
                height: 150.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: MyFavoriteIcon(isTapped: istap, movieId: movieId),
                ),
              ),
            ),
          ),

          Text(
            title,
            style: t4().copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          Text(subTitle, style: t4()),
        ],
      ),
    );
  }
}

class MyFavoriteIcon extends StatefulWidget {
  int? movieId;
  bool isTapped;
  MyFavoriteIcon({super.key, required this.isTapped, this.movieId});

  @override
  State<MyFavoriteIcon> createState() => _MyFavoriteIconState();
}

class _MyFavoriteIconState extends State<MyFavoriteIcon> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio dio = Dio();

  Future addFavoriteMovie(int movieId) async {
    try {
      final accesToken = await storage.read(key: "token");
      log("AcessToken:$accesToken!");
      final Response response = await dio.post(
        "${ApiHelpers.baseurl}${ApiHelpers.postFavourite}/$movieId",
        options: Options(
          headers: {
            "Authorization": "Bearer $accesToken",
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {}
    } on DioException catch (exe) {
      log("Error $exe");

      throw Exception(exe.toString());
    }
  }

  Future deleteFavorite(int movieId) async {
    final accesToken = await storage.read(key: "token");
    try {
      final Response response = await dio.delete(
        '${ApiHelpers.baseurl}/remove-favorite/$movieId',
        options: Options(
          headers: {
            "Authorization": "Barrer $accesToken",
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {}
    } on DioException catch (exe) {
      throw Exception(exe.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          widget.isTapped = !widget.isTapped;

          if (widget.isTapped) {
            addFavoriteMovie(widget.movieId!);
            mySnackBar(context, snackBarText: "Added Succsfully");
          } else {
            mySnackBar(context, snackBarText: "Deleted Sucessfully");
            deleteFavorite(widget.movieId!);
          }
        });
      },
      color: widget.isTapped ? Colors.black : Colors.grey.shade100,
      icon: widget.isTapped
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border_outlined),
    );
  }
}
