import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ModelClass/search_movies.dart';
import 'package:flutter_application_2/app/api/api_path.dart';
import 'package:flutter_application_2/app/utils/AppColor/app_color.dart';
import 'package:flutter_application_2/app/api/api_helpers.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController userSearchController = TextEditingController();
  final Dio dio = Dio();
  bool isLoading = false;
  List searchMoviesList = [];
  // Future<MovieResponseModel> getSearchMovies() async {
  //   try {
  //     final Response response = await dio.get(
  //       ApiHelpers.baseurl + ApiHelpers.homeUrl,
  //     );
  //     return MovieResponseModel.fromJson(response.data);
  //   } on DioException catch (exe) {
  //     throw Exception("Exception: $exe");
  //   }
  // }

  Future<void> postMovies(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final Response response = await dio.post(
        ApiPath.baseUrl + ApiPath.searchMovies,

        data: {"name": userSearchController.text.toString()},
      );
      if (response.statusCode == 200) {
        log("sucesfully");
        final searchedData = SearchMovies.fromJson(response.data);
        searchMoviesList = searchedData.data ?? [];

        mySnackBar(context, snackBarText: "showed Succesful");
      }
    } on DioException catch (exe) {
      mySnackBar(context, snackBarText: "Unable to load Movies $exe");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySearchTextField(
              onChanged: (value) {
                if (value.toString().isNotEmpty) {
                  postMovies(context);
                } else {
                  setState(() {
                    searchMoviesList.clear();
                  });
                }
              },
              controller: userSearchController,
              hintText: "Search for a show, movies....",
            ),
            Text("Top Search", style: t1().copyWith(fontSize: 18.sp)),
            SizedBox(height: 10.h),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: searchMoviesList.length,
                      itemBuilder: (context, index) {
                        return imageTile(
                          thumbnailUrl: searchMoviesList[index].thumbnailUrl!,
                          movietitle: searchMoviesList[index].title!,
                          onPressed: () {},
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget imageTile({
  required String thumbnailUrl,
  required String movietitle,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColor.searchBgColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.w,
              child: Image.network(thumbnailUrl, fit: BoxFit.fill),
            ),
            SizedBox(width: 20.w),
            Text(movietitle, style: t1().copyWith(fontSize: 18.sp)),
            Spacer(),

            IconButton(onPressed: onPressed, icon: Icon(Icons.play_arrow)),
          ],
        ),
      ),
    ),
  );
}
