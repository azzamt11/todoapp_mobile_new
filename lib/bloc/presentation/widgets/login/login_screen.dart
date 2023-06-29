import 'package:code/bloc/domain/login/login_bloc.dart';
import 'package:code/bloc/presentation/widgets/login/logged_out_widget.dart';
import 'package:code/bloc/presentation/widgets/login/register_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  late final LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc(NotLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
              decoration: BoxDecoration(

              ),
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          if (state is NotRegistered) {
            return RegisterWidget();
          } else if (state is NotLoggedIn) {
            return LoggedOutWidget();
          } else {
            return LoggedOutWidget();
          }
        },
      ),
    )
        )
    );
  }
}
