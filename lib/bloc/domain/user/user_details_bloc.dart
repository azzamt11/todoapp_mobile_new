import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code/bloc/data/model/user_details.dart';
import 'package:code/bloc/data/repository/user_details_repository.dart';
import 'package:meta/meta.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserRepositoryImpl userDetailsRepository;

  UserDetailsBloc({required this.userDetailsRepository})
      : super(UserDetailsLoading());

  @override
  Stream<UserDetailsState> mapEventToState(UserDetailsEvent event,) async* {
    yield UserDetailsLoading();
    try {
      var response = await userDetailsRepository.getAllUsers();

      if(response.isSuccessful){

        List<UserDetails>? list = response.body;

        await Future.delayed(Duration(seconds: 5));
        yield UserDetailsLoaded(
          list!.first
        );

      }else{
        yield UserDetailsError();
      }

    } catch (e) {
      print("Exception while fetching user details: " + e.toString());
      yield UserDetailsError();
    }
  }
}
