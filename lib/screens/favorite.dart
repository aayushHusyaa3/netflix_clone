import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ModelClass/favorite_model.dart';

import 'package:flutter_application_2/app/api/api_path.dart';
import 'package:flutter_application_2/app/utils/textStyles/textstyle.dart';
import 'package:flutter_application_2/app/utils/uiHelper/ui_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final Dio dio = Dio();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<FavoriteModel> getFavoriteMovies() async {
    final token = await storage.read(key: "token");
    try {
      final Response response = await dio.get(
        ApiPath.baseUrl + ApiPath.getFavourite,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return FavoriteModel.fromJson(response.data);
    } on DioError catch (exe) {
      throw Exception("Error fetching favorites: ${exe.message}");
    }
  }

  Future<void> deleteMovie(context, int movieId) async {
    final token = await storage.read(key: "token");

    try {
      final Response response = await dio.delete(
        "http://192.168.1.212:8000/api/remove-favorite/$movieId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("Delete URl ${ApiPath.baseUrl}${ApiPath.removeFavourite}/$movieId}");
      if (response.statusCode == 200) {
        getFavoriteMovies();
        mySnackBar(context, snackBarText: "Movie Removed Successfully");
      }
    } on DioError catch (exe) {
      mySnackBar(context, snackBarText: "Delete Failed $exe");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<FavoriteModel>(
        future: getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return Center(child: Text("No Favorite Movie Found"));
          } else if (snapshot.hasError) {
            return Center(child: Text("Errorasdadsad: ${snapshot.error}"));
          } else {
            final favoriteList = snapshot.data!.data!;

            return Padding(
              padding: EdgeInsets.all(25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Favorite", style: t1()),
                  Expanded(
                    child: ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) {
                        final favoriteSnapshot = favoriteList[index];
                        return Dismissible(
                          key: Key(""),
                          onDismissed: (_) {
                            deleteMovie(context, favoriteSnapshot.movie!.id!);
                            mySnackBar(
                              context,
                              snackBarText: "Removed Successfully",
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(
                                favoriteSnapshot.movie!.thumbnailUrl ?? "",
                              ),
                            ),
                            title: Text(
                              favoriteSnapshot.movie!.title ?? "No Title",
                              style: t4(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
