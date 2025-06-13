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
        data!.add(new Data.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
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
        genres!.add(new Genres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['release_date'] = this.releaseDate;
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    data['language'] = this.language;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['trailer_url'] = this.trailerUrl;
    data['video_url'] = this.videoUrl;
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
