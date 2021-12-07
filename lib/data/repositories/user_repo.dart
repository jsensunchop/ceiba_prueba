import 'package:dio/dio.dart';
import 'package:prueba_tecnica/data/services/rest_client.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';

class UserRepo {

  //API LIST QUERY REPO

  static final UserRepo _userRepo = UserRepo._internal();

  factory UserRepo(){
    return _userRepo;
  }
  UserRepo._internal();

  static final dio = Dio(BaseOptions(
    contentType: "application/json",
  ));

  RestClient _client = RestClient(dio);

  //Get all users from API
  Future<List<UserResponse>> fetchUsers() async{
    return await _client.getAllUsers();
  }
  //Get all posts from API
  Future<List<PostResponse>> fetchPosts() async{
    return await _client.getAllPosts();
  }
  //Get all posts by userID
  Future<List<PostResponse>> fetchPostsById(int id) async{
    return await _client.getPostsById(id);
  }


}