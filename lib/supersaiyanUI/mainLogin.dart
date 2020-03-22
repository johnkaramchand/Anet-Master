import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/export.dart' as p;
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http_auth/http_auth.dart' as httpauth;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

///import 'package:pointycastle/asymmetric/api.dart' as apobject;

import "package:pointycastle/export.dart" as exportpointy;
import "package:asn1lib/asn1lib.dart";

import 'package:anet/supersaiyan/super_bloc.dart';
import 'package:anet/supersaiyan/super_state.dart';
import 'package:anet/supersaiyanUI/supersaiyanlogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/login_bloc/login.dart';
import 'package:anet/authentication_bloc/authentication.dart';
import 'package:http/io_client.dart';
import 'package:simple_rsa/simple_rsa.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:anet/utils/tools.dart';
import 'package:anet/config/config_bloc.dart';
import 'package:anet/config/config_event.dart';
import 'package:anet/registerPageStateless/registerPageStateless.dart';
import '../utils/tools.dart';
import 'package:http_auth/http_auth.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/authentication_bloc/authentication.dart';
import "package:pointycastle/export.dart" as exp;

Uint8List _processInBlocks(exp.AsymmetricBlockCipher engine, Uint8List input) {
  final numBlocks = input.length ~/ engine.inputBlockSize +
      ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

  final output = Uint8List(numBlocks * engine.outputBlockSize);

  var inputOffset = 0;
  var outputOffset = 0;
  while (inputOffset < input.length) {
    final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
        ? engine.inputBlockSize
        : input.length - inputOffset;

    outputOffset += engine.processBlock(
        input, inputOffset, chunkSize, output, outputOffset);

    inputOffset += chunkSize;
  }

  return (output.length == outputOffset)
      ? output
      : output.sublist(0, outputOffset);
}

Uint8List rsaEncrypt(exp.RSAPublicKey myPublic, Uint8List dataToEncrypt) {
  final encryptor = exp.PKCS1Encoding(exp.RSAEngine())
    ..init(true,
        exp.PublicKeyParameter<exp.RSAPublicKey>(myPublic)); // true=encrypt

  return _processInBlocks(encryptor, dataToEncrypt);
}

class SuperLoginPage extends StatefulWidget {
  static const String routeName = "/superloginpage";
  @override
  State<SuperLoginPage> createState() => SuperLoginForm();
}

class SuperLoginForm extends State<SuperLoginPage> {
  static const String routeName = "/superloginpage";
  var encryptedText = '';
  String finaldude = '';
  @override
  void initState() {
    super.initState();
    ses();
    ConfigBloc().dispatch(DarkModeEvent(ConfigBloc().darkModeOn));
  }

  ses() async {
    var plaintext = "2020";
    var public_key =
        'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1Nrr7gsMxSv+WN/eaJJE0JcOce8McNfRMK0pYKFrwuyvEj6W0sul+npdIlz6eT69SZA5uh+kmjVa4jHj2CPdEXrtuECl761acyay+nTDpxBNAu5lNZmN3roD+sBciGmqX0A2Awlb78mq/cjf+Jm2TRf2o6Pkv5FLocDAo7FgPIwIDAQAB';

    ///var b64 = base64Encode(utf8.encode(public_key));
    var javaEncoded = public_key;
    var pem =
        '-----BEGIN RSA PUBLIC KEY-----\n$javaEncoded\n-----END RSA PUBLIC KEY-----';
    print("pem $pem");
//    p.RSAPublicKey public = X509Utils.publicKeyFromPem(pem);
    //var cipher = new exportpointy.RSAEngine()
    //..init(true, new exportpointy.PublicKeyParameter<exportpointy.RSAPublicKey>(public));
    //var cipherText = cipher.process(new Uint8List.fromList(plaintext.codeUnits));

//    encryptedText =  String.fromCharCodes(cipherText);

    //  String s = new String.fromCharCodes(yo);

/*     var yo = rsaEncrypt(public, new Uint8List.fromList(plaintext.codeUnits));
    encryptedText = yo.toString();
    String s = new String.fromCharCodes(yo);
    print(s.codeUnits);
 */ //  var outputAsUint8List = new Uint8List.fromList(s.codeUnits);
    //print(outputAsUint8List);

    /* encryptedText =
        await encryptString("2020", public); */

    /// ANOTHER NEW METHOD

/*     var plainText = "2020";
    exportpointy.AsymmetricKeyParameter<exportpointy.RSAPublicKey> keyParametersPublic =
        new exportpointy.PublicKeyParameter(public);

    var cipher = new exportpointy.PKCS1Encoding(exportpointy.RSAEngine())
    ..init(true, keyParametersPublic);

    var cipherText =
        cipher.process(new Uint8List.fromList(plainText.codeUnits));
        /// FINAL AGAIn
          final publicKey = await p.parseKeyFromFile<exportpointy.RSAPublicKey>('test/public.pem');
 */

    //final decrypted = encrypter.decrypt(encrypted);
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var client = new DigestAuthClient("erpclient", '#edu\$erp#2016\$');
  var url = 'https://ait.academiaerp.com/oauth/token';

  @override
  Widget build(BuildContext context) {
    // BorderRadiusGeometry radius = BorderRadius.only(
    //   topLeft: Radius.circular(24.0),
    //   topRight: Radius.circular(24.0),
    // );

    //var homeBloc = BlocProvider.of<HomeBloc>(context);
    //var auth = BlocProvider.of<AuthenticationBloc>(context);
    print(encryptedText);
    return BlocListener<SuperSaiyanBloc, SuperSaiyanState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              //content: Text('${state.error}'),
              content: Text('cdscdscs'),
              backgroundColor: Colors.red,
            ),
          );
        }
        /*       if (state is LoginLoading) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              //content: Text('${state.error}'),
              content: Text('Registering.....'),
              backgroundColor: Colors.red,
            ),
          );
        } */
      },
      child: BlocBuilder<SuperSaiyanBloc, SuperSaiyanState>(
          builder: (context, state) {
        /*    if (state is LoginLoading) {
          
          return LoadingIndicator();
        } else { */
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
                    top: MediaQuery.of(context).size.height / 3 + 10,
                    left: 1,
                    right: 1,
                    child: Column(
                      children: <Widget>[
/*                           GestureDetector(
                            onTap: (){

                            ConfigBloc()
                      .dispatch(DarkModeEvent(!ConfigBloc().darkModeOn));
                            },
                            child: Text(
                              'Academia Login',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ), */
                        Text(
                          'ACADEMIA CREDENTIALS',
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
                            labelText: 'username',
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
                          onPressed: () async {
                            /*  print("Button Pressed");
                              state is! LoginLoading
                                  ? _onLoginButtonPressed()
                                  : null; */

                            try {
                              var publicKey =
                                  '';
                              final encrypted =
                                  await encryptString("2020", publicKey);
                              
                              var CLIENT_ID = 'erpclient';
                              var CLIENT_SECRET = '#edu\$erp#2016\$';

                              Map<String, dynamic> body = {
                                "grant_type": "password",
                                "username": "1AT16CS0390",
                                "password": "$encrypted",
                              };


                              var body2 =  {"grant_type": "password", "username": "1AT16CS039", "password": encrypted };

                              print("THIS IS BODY $body");
                              String basicAuth = 'Basic ' +
                                  base64Encode(
                                      utf8.encode('$CLIENT_ID:$CLIENT_SECRET'));
                              var clientcred = HttpClientBasicCredentials(
                                  CLIENT_ID, CLIENT_SECRET);



                                              
                             
                              var url =
                                  'https://ait.academiaerp.com/oauth/token';
                              
                              var response = await http.post(
                                  'https://ait.academiaerp.com/oauth/token',
                                  headers: {
                                    
                                    HttpHeaders.authorizationHeader: basicAuth,
                                    "Accept": "application/json",
                                    "Content-Type":
                                        "application/x-www-form-urlencoded;charset=UTF-8",
                                  },
                                  body: body2,
                                  encoding: Encoding.getByName("utf-8"));
                              print(response.body); 
                            } catch (error) {
                              print("Something went wrong $error");
                            }
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

                      SizedBox(width: 5.0),
                      Container(
                        //alignment: Alignment(1.0, 0.0),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                        child: InkWell(
                          onTap: () {
                            //authbloc.dispatch(Register());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterStateless(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign up ?',
                            style: TextStyle(
                                color: Tools.multiColors[4],
                                fontFamily: 'JosefinSans',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      /*  InkWell(
                              onTap: () {
                              print("Tapped");
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
                            ) */
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
                /* Positioned(
                    bottom: 1,
                    left: 1,
                    child: Image.asset(
                      "assets/images/bottom-left-lines.png",
                      width: 250,
                      height: 250,
                      alignment: Alignment.bottomLeft,
                    ),
                  ), */
              ],
            ));
        //      }
      }),
    );

    /* DevScaffold(
      body: HomeScreen(homeBloc: homeBloc),
      // body: SlidingUpPanel(
      //   parallaxEnabled: true,
      //   backdropEnabled: true,
      //   backdropTapClosesPanel: true,
      //   maxHeight: MediaQuery.of(context).size.height * 0.6,
      //   color: Theme.of(context).primaryColor,
      //   panel: HomeSlidingPanel(),
      //   collapsed: AnimatedContainer(
      //     duration: Duration(milliseconds: 500),
      //     decoration: BoxDecoration(
      //       color: Theme.of(context).primaryColor,
      //     ),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       mainAxisSize: MainAxisSize.max,
      //       children: <Widget>[
      //         AnimatedContainer(
      //           duration: Duration(milliseconds: 500),
      //           height: 5.0,
      //           width: MediaQuery.of(context).size.width * 0.08,
      //           decoration: BoxDecoration(
      //             color:
      //                 ConfigBloc().darkModeOn ? Colors.white : Colors.grey[300],
      //             borderRadius: BorderRadius.circular(5.0),
      //           ),
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: <Widget>[
      //             CircleAvatar(
      //               radius: 15,
      //               backgroundImage: CachedNetworkImageProvider(
      //                   "https://pbs.twimg.com/media/D22N_huX4AEbb1y.jpg"),
      //             ),
      //             SizedBox(
      //               width: 15,
      //             ),
      //             Text(
      //               "Locate Us",
      //               textAlign: TextAlign.center,
      //               style: Theme.of(context).textTheme.title,
      //             ),
      //             SizedBox(
      //               width: 0,
      //             ),
      //             IconButton(
      //               onPressed: () => Share.share(
      //                   "Download the new DevFest App and share with your tech friends.\nPlayStore -  http://bit.ly/2GDr18N"),
      //               icon: Icon(
      //                 Icons.share,
      //                 size: 20,
      //               ),
      //             ),
      //           ],
      //         ),
      //         Offstage()
      //       ],
      //     ),
      //   ),
      //   body: HomeScreen(homeBloc: _homeBloc),
      // ),
      title: "Home",
    ); */
  }

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<T> customparseKeyFromFile<T extends RSAAsymmetricKey>(
      String key) async {
    final parser = RSAKeyParser();
    return parser.parse(key) as T;
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
