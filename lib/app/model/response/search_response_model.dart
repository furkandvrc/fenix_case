import 'package:background_json_parser/background_json_parser.dart';

class SearchResponseModel extends IBaseModel<SearchResponseModel> {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  SearchResponseModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  SearchResponseModel fromJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List;
    List<Result> resultList = resultsList.map((result) => Result.fromJson(result)).toList();
    return SearchResponseModel(
      page: json["page"],
      results: resultList,
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

class Result {
  String? title;
  String? posterPath;

  Result({
    this.title,
    this.posterPath,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      title: json['original_title'],
      posterPath: json['poster_path'],
    );
  }
}
