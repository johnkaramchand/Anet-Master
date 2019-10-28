import 'package:flutter/material.dart';
import 'package:anet/authentication_bloc/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                bloc.dispatch(LoggedOut());
              },
              child: Text("login"),
            )
          ],
        ),
      ),
    );
  }
}
