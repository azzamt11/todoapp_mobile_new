

import 'package:chopper/chopper.dart';
import 'package:code/bloc/data/model/user_details.dart';
import 'package:code/bloc/data/repository/user_repository.dart';
import 'package:code/bloc/data/service/user_service.dart';


class UserRepositoryImpl implements UserRepository{
  final UserService userService;

  UserRepositoryImpl({required this.userService});



  @override
  Future<Response<List<UserDetails>>> getAllUsers() async {
    var response = await userService.getAllUsers();
    return response.copyWith(body: List<UserDetails>.from(response.body.map((e) => UserDetails.fromJson(e))));
  }

  @override
  Future<Response<UserDetails>> getUserDetails(int id) async {
    var response = await userService.getUserDetails(id);
    return  response.copyWith(body: UserDetails.fromJson(response.body));
  }

}

