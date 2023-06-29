import 'package:code/bloc/data/repository/user_details_repository.dart';
import 'package:code/bloc/data/repository/user_repository.dart';
import 'package:code/bloc/domain/user/user_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/barcode_scanner_widget.dart';
import 'widgets/user_details_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final UserRepositoryImpl _userDetailsRepository;
  late final UserDetailsBloc _userDetailsBloc;

  @override
  void initState() {
    _userDetailsRepository = RepositoryProvider.of<UserRepositoryImpl>(context);
    _userDetailsBloc =
        UserDetailsBloc(userDetailsRepository: _userDetailsRepository);
    _userDetailsBloc.add(UserDetailsInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WFO Gamification'),
      ),
      body: Center(
        child: BlocBuilder(
            bloc: _userDetailsBloc,
            builder: (BuildContext context, UserDetailsState state) {
              //return MobileQRScanner();
              if (state is UserDetailsLoading) {
                return CircularProgressIndicator();
              }
              if (state is UserDetailsLoaded) {
                return UserDetailsWidget(userDetails: state.userDetails);
              }
              return Text('Unable to fetch the user details!!!');
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: "Details"
        )
      ],

      ),
    );
  }
}
