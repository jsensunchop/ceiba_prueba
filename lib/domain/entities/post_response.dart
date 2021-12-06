import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

///PODO ApiResponse

@JsonSerializable()
class PostResponse {
  int userId;
  int id;
  String title;
  String body;

  PostResponse(this.userId, this.id, this.title, this.body);

  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}