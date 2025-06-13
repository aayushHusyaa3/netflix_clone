class FavoriteModel {
  bool? status;
  String? message;
  List<Data>? data;
  Null token;

  FavoriteModel({this.status, this.message, this.data, this.token});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  int? id;
  int? profileId;
  int? movieId;
  String? createdAt;
  String? updatedAt;
  Movie? movie;

  Data({
    this.id,
    this.profileId,
    this.movieId,
    this.createdAt,
    this.updatedAt,
    this.movie,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    movieId = json['movie_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_id'] = profileId;
    data['movie_id'] = movieId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (movie != null) {
      data['movie'] = movie!.toJson();
    }
    return data;
  }
}

class Movie {
  int? id;
  String? title;
  String? description;
  String? releaseDate;
  int? duration;
  String? rating;
  String? language;
  String? thumbnailUrl;
  String? trailerUrl;
  String? videoUrl;
  String? createdAt;
  Null updatedAt;

  Movie({
    this.id,
    this.title,
    this.description,
    this.releaseDate,
    this.duration,
    this.rating,
    this.language,
    this.thumbnailUrl,
    this.trailerUrl,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    releaseDate = json['release_date'];
    duration = json['duration'];
    rating = json['rating'];
    language = json['language'];
    thumbnailUrl = json['thumbnail_url'];
    trailerUrl = json['trailer_url'];
    videoUrl = json['video_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['release_date'] = releaseDate;
    data['duration'] = duration;
    data['rating'] = rating;
    data['language'] = language;
    data['thumbnail_url'] = thumbnailUrl;
    data['trailer_url'] = trailerUrl;
    data['video_url'] = videoUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
