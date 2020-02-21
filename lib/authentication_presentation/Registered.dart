import 'package:flutter/material.dart';
import 'package:anet/authentication_bloc/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: Center(
          child: new Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sucessfully Registered.',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Activation link has been mailed to you.\nVerify to login!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 40.0,
              child: SizedBox.expand(
                child: RaisedButton(
                  onPressed: () {
                    bloc.dispatch(LoggedOut());
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  shape: StadiumBorder(),
                  color: Colors.green,
                  splashColor: Colors.greenAccent,
                  colorBrightness: Brightness.dark,
                ),
              ),
            ),
            /* SvgPicture.asset('/mages/mello.svg',
                color: Colors.red, semanticsLabel: 'A red up arrow') */
          ],
        ),
      )),
    );
  }
}
