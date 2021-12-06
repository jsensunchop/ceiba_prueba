import 'package:dio/dio.dart';
import 'package:prueba_tecnica/data/services/rest_client.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';

class UserRepo {

  static final UserRepo _userRepo = UserRepo._internal();

  factory UserRepo(){
    return _userRepo;
  }
  UserRepo._internal();

  static final dio = Dio(BaseOptions(
    contentType: "application/json",
  ));

  RestClient _client = RestClient(dio);

  Future<List<UserResponse>> fetchUsers() async{
    return await _client.getAllUsers();
  }

  Future<List<PostResponse>> fetchPosts() async{
    return await _client.getAllPosts();
  }
  Future<List<PostResponse>> fetchPostsById(int id) async{
    return await _client.getPostsById(id);
  }


}