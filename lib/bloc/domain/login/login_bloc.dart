

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
     yield NotLoggedIn();
  }
}
