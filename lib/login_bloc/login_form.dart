import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/login_bloc/login.dart';
import 'package:anet/login_bloc/signup_page.dart';
import 'package:anet/authentication_bloc/authentication.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'package:anet/utils/tools.dart';
import 'dart:math';

import 'package:anet/config/config_bloc.dart';
import 'package:anet/config/config_event.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/tools.dart';
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

    _onLoginButtonPressed() async {
      print(_usernameController.text);
      /*var response;
      Map<String, String> headers = {"Content-type": "application/json"};
      String jsonRequest = '{"email": "test@gmail.com", "password":"whatbro1"}';
      response = await http.post('https://cia.atria.edu/rest/login/',
          body: jsonRequest, headers: headers);
      print(response.body);*/
      loginBloc.dispatch(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }
GlobalKey<FormState> _abcKey = GlobalKey<FormState>();

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
        if (state is LoginLoading) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              //content: Text('${state.error}'),
              content: Text('Registering.....'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoading) {
          return LoadingIndicator();
        } else {
          final _screenSize = MediaQuery.of(context).size;

          return Container(
              height: _screenSize.height,
              child: Stack(
                overflow: Overflow.clip,
                //fit: StackFit.values[StackFit.values,],
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Positioned(
                    right: -10,
                    child: Image.asset(
                      "assets/images/top-right-lines.png",
                      width: 280,
                      height: 280,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height / 5 + 10,
                      left: 1,
                      right: 1,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){

                            ConfigBloc()
                      .dispatch(DarkModeEvent(!ConfigBloc().darkModeOn));
                            },
                            child: Text(
                              'CIA',
                              style: TextStyle(
                                fontSize: 120.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            'COMMUNITIES IN ATRIA',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Tools.multiColors[4]),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 5,
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.width / 5,
                        0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /*  SizedBox(
                  height: 20,
                ), */

                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'email',
                              labelStyle: TextStyle(
                                  //fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Tools.multiColors[4]))),
                          controller: _usernameController,
                        ),
                        SizedBox(height: 5.0),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'password',
                              labelStyle: TextStyle(
                                  //fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Tools.multiColors[4]))),
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        /* SizedBox(height: 5.0), */
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            onTap: () async {
                              await _launchURL(
                                  "https://twitter.com/cia_together");
                            },
                            child: Text(
                              //'Forgot Password',

                              'Forgot Password',
                              style: TextStyle(
                                  color: Tools.multiColors[4],
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          height: 40.0,
                          child: RaisedButton(
                            onPressed: () {
                              print("Button Pressed");
                              state is! LoginLoading
                                  ? _onLoginButtonPressed()
                                  : null;
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            color: Tools.multiColors[4],
                            splashColor: Tools.multiColors[4],
                            colorBrightness: Brightness.dark,
                          ),
                        ),
                        SizedBox(height: 15.0),
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
                                  color: Tools.multiColors[4])),
                        )
                      ],
                    ),
                  ), */

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /*  Text(
                          'New to CIA platform ?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ), */
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).pushNamed('/tempsignup');
                                authbloc.dispatch(Register());
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    color: Tools.multiColors[4],
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                  /*  Image.asset("assets/images/splash-screen-logo.png",width: 200,height: 200,alignment: Alignment.center,),
                  Positioned(
            width: 350.0,
            //top: MediaQuery.of(context).size.height / 2,
            child:    Image.asset("assets/images/bottom-left-lines.png",width: 200,height: 200,alignment: Alignment.center,)
            ), */

                  /* Container(
                  
                  margin: EdgeInsets.fromLTRB(0, 200, 0,0),
                  child: Text(
                      'CIA',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      

                    ),
                ), */

                  /*  Row(children: <Widget>[
                      Text(
                        'Communities In Atria',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Tools.multiColors[4]),
                      ),
                    ]), */

                  ,
                  Positioned(
                    bottom: 1,
                    left: 1,
                    child: Image.asset(
                      "assets/images/bottom-left-lines.png",
                      width: 250,
                      height: 250,
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                ],
              ));
        }
      }),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
