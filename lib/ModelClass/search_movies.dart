class SearchMovies {
  bool? status;
  String? message;
  List<Data>? data;
  Null token;

  SearchMovies({this.status, this.message, this.data, this.token});

  SearchMovies.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? releaseDate;
  int? duration;
  String? rating;
  String? language;
  String? thumbnailUrl;
  String? trailerUrl;
  String? videoUrl;
  List<Genres>? genres;

  Data({
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
    this.genres,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
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
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
