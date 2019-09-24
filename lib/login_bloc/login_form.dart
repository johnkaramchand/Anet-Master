import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/login_bloc/login.dart';

class LoginForm extends StatefulWidget {
  @override State < LoginForm > createState() => _LoginFormState();
}

class _LoginFormState extends State < LoginForm > {
  final _usernameController = TextEditingController();
  //  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of < LoginBloc > (context);

    _onLoginButtonPressed() {
      loginBloc.dispatch(LoginButtonPressed(username: _usernameController.text,
        //   email: _emailController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener < LoginBloc,
      LoginState > (listener: (context, state) {
          if (state is LoginFailure) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ), );
          }
        }

        ,
        child: BlocBuilder < LoginBloc, LoginState > (builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [TextField(decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
                /*  TextFormField(
                      decoration: InputDecoration(labelText: 'email'),
                      controller: _emailController,
                    ),*/
                TextField(decoration: InputDecoration(labelText: 'password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                RaisedButton(onPressed: state is!LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Login'),
                ),
                Container(child: state is LoginLoading ? CircularProgressIndicator() : null, ),
              ],
            ),
            );
          }

          ,
        ),
      );
  }
}