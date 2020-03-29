import 'package:anet/authentication_bloc/user_repository.dart';
import 'package:anet/supersaiyanUI/mainLogin.dart';
import 'package:anet/supersaiyanUI/supersaiyanhome.dart';
import 'package:flutter/material.dart';
import 'package:anet/projectsNav/projectIdeasScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/supersaiyan/super.dart';
import 'package:anet/supersaiyan/super_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:anet/supersaiyan/super_state.dart';
import 'package:anet/supersaiyan/super_events.dart';

class SuperSaiyanLoginPage extends StatelessWidget {
  static const String routeName = "/supersaiyanlogin";
final UserRepository userRepository;
  SuperSaiyanLoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    

    //var superSaiyanBLoc = BlocProvider.of<SuperSaiyanBloc>(context);
    return Material(
      child: BlocProvider<SuperSaiyanBloc>(
        builder: (context){
          return SuperSaiyanBloc(userRepository: userRepository)
        ..dispatch(SuperSaiyanStarted());


        },
    child: BlocBuilder<SuperSaiyanBloc,SuperSaiyanState>(
      builder: (context,state){

       
        
      if(state is SuperSaiyanLoggedout){
        
        print("SUPER LOGIN PAGE");
                return SuperLoginPage();
      }
      else{
        print("SUPER LOGIN PAGE");
        print("ITS LOGGED UN BRO");
                return SuperSaiyanHome();

      }
      
    

    },)),
    );
    
    /* DevScaffold(
        title: "Projects",
        body: 
            ProjectsPageScreen(
              homeBloc: _homeBloc,
            ),/*
            WebScreen(
              homeBloc: _homeBloc,
            ),*/
          
        
      
    ); */
  }
}
