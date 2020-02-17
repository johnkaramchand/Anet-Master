import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anet/utils/tools.dart';

class RegisterStateless extends StatefulWidget {
    static const String routeName = "/registerstateless";
  @override
  State<StatefulWidget> createState() {
    return _RegisterStateless();
  }
}

class _RegisterStateless extends State<RegisterStateless> {
  bool current;
  final snackBar = SnackBar(content: Text('FAILED'));

  @override
  void initState() {
    super.initState();
    current = true;
    //getToken();
  }
  
  
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _usnController = TextEditingController();
  //final _deptController = TextEditingController();
  final _ut_idController = TextEditingController();
  final _phone_numberController = TextEditingController();

  final key = GlobalKey<FormState>();

  var departmentValue = 1;
 @override
  Widget build(BuildContext context) {


  registerapi( 
      {@required String username,
      @required String email,
      @required String password1,
      @required String password2,
      @required String usn,
      @required int dept,
      @required int ut_id,
      @required String phone_number}) async {

    setState(() {
      current = false;
    });


    var response;
    Map<String, String> headers = {"Content-type": "application/json"};

    //String jsonRequest = '{"token": "$token", "e_code":"$eventcode"}';
    String jsonRequest =
        '{"username": "${username.trim()}", "password1":"${password1.trim()}", "password2":"${password2.trim()}","email":"${email.trim()}","usn":"${usn.trim()}","dept":"$dept","ut_id":"$ut_id","phone_number":"${phone_number.trim()}"}';
    //  String jsonRequest = '{"username": "$username", "email": "$email", "password":"$password"}';
    // String jsonRequest = '{"username": "test1", "email": "test@gmail.com", "password":"whatbro1"}';
    // await Future.delayed(Duration(seconds: 1)) ;
    //return 'token' ;
    print("SURYA THIS IS THE DATA : $jsonRequest");
    try {
      print('api test');
      response = await http.post('http://test.ciadev.ninja/rest/register/',
          body: jsonRequest, headers: headers);
      print(response.body);
      var res = json.decode(response.body);
      print(res);
      if (res['status'] == 'ACTIVATE') {
        print("DONE REGISTERING");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            error: 'Registered !\n We\'ve mailed an activation link. Use it to activate and then Login.',
            onTap: () {
              Navigator.pop(context);
              setState(() {
                current = true;
                
              });
              //_homeBloc.dispatch(LoadHomeEvent());
            },
          ),
        );
      } else {
        print("Failed");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            error: 'ERROR',
            onTap: () {
              setState(() {
                current = true;
              });
              //_homeBloc.dispatch(LoadHomeEvent());
            },
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          error: 'Error',
          onTap: () {
            setState(() {
              current = true;
            });
            //_homeBloc.dispatch(LoadHomeEvent());
          },
        ),
      );
    }

    //var jsonresponse = json.decode(response.body);

    //  print("response : $jsonresponse");
  }








    return Scaffold(
      //title: 'Rewards',
      body: current ? 
     SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
                    
              SizedBox(
                height: 20,
              ),

              Center(
                child: Text(
                              'CIA',
                              style: TextStyle(

                                fontSize: 100.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
              )
              ,
              SizedBox(
                height: 20,
              ),

              Text(
                'You\'re a form away from being a part of the community',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
             /*  SizedBox(
                height: 4,
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
                        color: Tools.multiColors[4]),
                  ),
                ],
              ), */
              SizedBox(
                height: 20,
              ),
              Form(
                //autovalidate: false,
                key: key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                //fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:Tools.multiColors[4] ))),
                        controller: _usernameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Username cannot be empty';
                          } else if (value.toString().length < 5) {
                            return 'Username length is small';
                          } else {
                            return null;
                          }
                        }

                        //onSaved: (value) => name = value,
                        ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password ',
                          labelStyle: TextStyle(
                              //fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Tools.multiColors[4]))),
                      controller: _password1Controller,
                      obscureText: true,
                      validator: validatePassword,
                      //onSaved: (value) => name = value,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Re-enter Password ',
                            labelStyle: TextStyle(
                                ////fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Tools.multiColors[4]))),
                        controller: _password2Controller,
                        validator: (value) {
                          if (value.toString() !=
                              _password1Controller.text.toString()) {
                            return "Password doesn't match";
                          }
                        }),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              //fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Tools.multiColors[4]))),
                      controller: _emailController,
                      validator: validateEmail,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                          labelText: 'USN',
                          labelStyle: TextStyle(
                              //fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Tools.multiColors[4]))),
                      controller: _usnController,
                      validator: (value) =>
                          value.isEmpty ? "Field cannot be empty" : null,
                    ),
                    SizedBox(height: 10.0),
                    /*   TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Department',
                              labelStyle: TextStyle(
                                  //fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Tools.multiColors[4]))),
                          // controller: _usnController,
                          validator: (value) =>
                              value.isEmpty ? "Field cannot be empty" : null,
                        ), */
                    DropdownButtonFormField<int>(
                      isExpanded: true,
                      items: [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Computer Science & Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text(
                            "Information Science  & Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text(
                            "Electronics & Communication Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 4,
                          child: Text(
                            "Mechanical Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 5,
                          child: Text(
                            "Civil Engineering",
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 6,
                          child: Text(
                            "MBA",
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        print("value: $value");
                        setState(() {
                          departmentValue = value;
                        });
                      },
                      value: departmentValue,
                      hint: Text(
                        "Please select the number!",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone Number (XXXXXXXXXX)',
                          labelStyle: TextStyle(
                              //fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Tools.multiColors[4]))),
                      controller: _phone_numberController,
                      validator: validateMobile,
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Tools.multiColors[4],
                          color: Tools.multiColors[4],
                          elevation: 7.0,
                          child: SizedBox.expand(
                            child: RaisedButton(
                              onPressed: () {
                                print("hi");
                                if (key.currentState.validate()) {
                                  print("ih");
                                  print("Hi.... KAKAKEKETUKETUKE!!");
                                  registerapi(
                                    username: _usernameController.text.trim(),
          password1: _password1Controller.text.trim(),
          email: _emailController.text,
          usn: _usnController.text,
          dept: departmentValue,
          ut_id: 1,
          phone_number: '+91' + _phone_numberController.text,
          password2: _password2Controller.text
                                    );
                                  
                                 // onRegisterButtonPressed();
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
                              color: Tools.multiColors[4],
                              splashColor: Tools.multiColors[4],
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
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            //authbloc.dispatch(LoggedOut());
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
              )
            ]),
          ): _loadScreen(),
    );

    /*var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return SessionList(
      allSessions: cloudSessions,
    );*/
  }

   Widget _loadScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


 


  String validateEmail(String value) {
    //Pattern pattern = r'^*';
    //r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    //RegExp regex = new RegExp(pattern);
    //if (!regex.hasMatch(value))
    // return 'Enter Valid Email';
    //else
    return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 7)
      return 'Password length must be > 7 charaters';
    else
      return null;
  }
}

class Dialog extends StatelessWidget {
  final Widget child;
  final error;
  final Function onTap;

  Dialog({Key key, this.child, this.error = 'okay', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(error),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  shape: StadiumBorder(),
                  colorBrightness: Brightness.dark,
                  child: Text('okay'),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                    if (onTap != null) {
                      onTap();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
