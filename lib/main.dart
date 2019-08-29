import 'package:firebase_practice_login/home_screen.dart';
import 'package:firebase_practice_login/simple_bloc_delegate.dart';
import 'package:firebase_practice_login/splash_screen.dart';
import 'package:firebase_practice_login/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc/bloc.dart';
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
//    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
//    _authenticationBloc.dispatch(AppStarted());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: _userRepository)
          ..dispatch(AppStarted());
      },
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              print(state.toString());
              if (state is Uninitialized) {
                return SplashScreen();
              }
              if (state is Authenticated) {
                return HomeScreen(name: state.displayName);
              }
            }),
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              print(state.toString());
              return Container(
                child: Center(
                  child: Text(state.toString()),
                ),
              );
            }),
      ),
    );
  }*/

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
