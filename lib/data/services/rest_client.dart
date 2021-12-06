// import 'package:retrofit_generator/retrofit_generator.dart'; // Solo quitar para correr build runner
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;


part 'rest_client.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @GET("users")
  Future<List<UserResponse>> getAllUsers();

  @GET("posts")
  Future<List<PostResponse>> getAllPosts();

  @GET("posts?userId={id}")
  Future<List<PostResponse>> getPostsById(@Path("id") int userId);


}
