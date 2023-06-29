import 'package:code/bloc/data/model/user_details.dart';
import 'package:chopper/chopper.dart';

abstract class UserRepository{
  Future<Response> getAllUsers();
  Future<Response> getUserDetails(int id);

}