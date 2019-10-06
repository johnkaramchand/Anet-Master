import 'package:anet/authentication_bloc/user_repository.dart';
import 'package:anet/login_bloc/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/universal/dev_scaffold.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = "/signup";

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _usnController = TextEditingController();
  final _deptController = TextEditingController();
  final _ut_idController = TextEditingController();
  final _phone_numberController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    onRegisterButtonPressed() {
      loginBloc.dispatch(RegisterButtonPressed(
          username: _usernameController.text,
          password1: _password1Controller.text,
          email: _emailController.text,
          usn: _usnController.text,
          //dept: _deptController.text,
          //ut_id: _ut_idController.text,
          phone_number: _phone_numberController.text,
          password2: _password2Controller.text));
    }

    // final GlobalKey < FormState > formKey1 = GlobalKey < FormState > ();

    return DevScaffold(
      title: "Signup",
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is RegistrationFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return new Scaffold(
                resizeToAvoidBottomPadding: true,
                body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                                child: Text(
                                  'Signup',
                                  style: TextStyle(
                                      fontSize: 80.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                                child: Text(
                                  '.',
                                  style: TextStyle(
                                      fontSize: 80.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                top: 35.0, left: 20.0, right: 20.0),
                            child: Form(
                              //autovalidate: false,
                              key: key,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Username',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        // hintText: 'EMAIL',
                                        // hintStyle: ,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    controller: _usernameController,
                                    validator: (value) => value.isEmpty
                                        ? "Field cannot be empty"
                                        : null,
                                    //onSaved: (value) => name = value,
                                  ),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Password ',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    controller: _password1Controller,
                                    obscureText: true,
                                    validator: (value) => value.isEmpty
                                        ? "Field cannot be empty"
                                        : null,
                                    //onSaved: (value) => name = value,
                                  ),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Re-enter Password ',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    controller: _password2Controller,
                                    validator: (value) => value.isEmpty
                                        ? "Field cannot be empty"
                                        : null,
                                  ),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    controller: _emailController,
                                    validator: (value) => value.isEmpty
                                        ? "Field cannot be empty"
                                        : null,
                                  ),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'USN',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    controller: _usnController,
                                    validator: (value) => value.isEmpty
                                        ? "Field cannot be empty"
                                        : null,
                                  ),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Department',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    controller: _usnController,
                                    validator: (value) => value.isEmpty
                                        ? "Field cannot be empty"
                                        : null,
                                  ),
                                  SizedBox(height: 10.0),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    controller: _phone_numberController,
                                    validator: (value) => value.isEmpty
                                        ? "Field cannot be empty"
                                        : null,
                                  ),
                                  SizedBox(height: 50.0),
                                  Container(
                                      height: 40.0,
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        shadowColor: Colors.greenAccent,
                                        color: Colors.green,
                                        elevation: 7.0,
                                        child: SizedBox.expand(
                                          child: RaisedButton(
                                            onPressed: () {
                                              if (key.currentState.validate()) {
                                                print(
                                                    "Hi.... KAKAKEKETUKETUKE!!");
                                                onRegisterButtonPressed();
                                                //Navigator.of(context).pop();
                                              }
                                            },
                                            child: Text(
                                              'SIGNUP',
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
                                      )),
                                  SizedBox(height: 20.0),
                                  Container(
                                    height: 40.0,
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 1.0),
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Center(
                                          child: Text('Go Back',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat')),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ]),
                ));
          },
        ),
      ),
    );
  }
}
