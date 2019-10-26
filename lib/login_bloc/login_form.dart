import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/login_bloc/login.dart';
import 'package:anet/login_bloc/signup_page.dart';
import 'package:anet/authentication_bloc/authentication.dart';
/*
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
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
              /*  TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  controller: _emailController,
                ),*/
TextFormField(
    decoration: InputDecoration(labelText: 'password'),
    controller: _passwordController,
    obscureText: true,
  ),
  RaisedButton(
    onPressed:
    state is!LoginLoading ? _onLoginButtonPressed : null,
    child: Text('Login'),
  ),
  Container(
    child: state is LoginLoading ?
    CircularProgressIndicator() :
    null,
  ),
],
),
);
},
),
);
}
}
*/

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final authbloc = BlocProvider.of<AuthenticationBloc>(context);

    _onLoginButtonPressed() {
      print(_usernameController.text);
      loginBloc.dispatch(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              //content: Text('${state.error}'),
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Hello',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'CommunitiesIN',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Atria',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'USERNAME',
                    labelStyle: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                controller: _usernameController,
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment(1.0, 0.0),
                padding: EdgeInsets.only(top: 15.0, left: 20.0),
                child: InkWell(
                  child: Text(
                    //'Forgot Password',

                    'Forgot Password',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                height: 40.0,
                child: SizedBox.expand(
                  child: RaisedButton(
                    onPressed: () {
                      state is! LoginLoading ? _onLoginButtonPressed() : null;
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    shape: StadiumBorder(),
                    color: Colors.green,
                    splashColor: Colors.greenAccent,
                    colorBrightness: Brightness.dark,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              /*     Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                          child: Text('Hello',
                              style: TextStyle(
                                  fontSize: 80.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                          child: Text('There',
                              style: TextStyle(
                                  fontSize: 80.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                          child: Text('.',
                              style: TextStyle(
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        )
                      ],
                    ),
                  ), */

              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New to CIA platform ?',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed('/tempsignup');
                      authbloc.dispatch(Register());
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
