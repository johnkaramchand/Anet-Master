import 'dart:math';

import 'package:anet/news_details.dart';
import 'package:flutter/material.dart';
import 'package:anet/agenda/pastevents_screen.dart';
import 'package:anet/agenda/web_screen.dart';
import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';


class NewsPage extends StatelessWidget {
  static const String routeName = "/news";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return  DevScaffold(
        title: "News",
       
        body: NewsScreen(
              homeBloc: _homeBloc,
            ),
      );
  }
}

class NewsScreen extends StatelessWidget {
  final HomeBloc homeBloc;
   NewsScreen({Key key, this.homeBloc}) : super(key: key);
  final RefreshController _refreshController = RefreshController();

  
  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    var news = state.newsData.news;
    var newsList = news.where((s) => s.news_id != 0).toList();
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
       // header: defaultHeader,
        onRefresh: () async {
          print("Pulled down");
             homeBloc.dispatch(LoadEventsEvent());
             
             var news = state.newsData.news;
             newsList = news.where((s) => s.news_id != 0).toList();
          _refreshController.refreshCompleted();
        },
        child:buildlist(newsList,context)
        //EventList( allEvents: eventSessions)
        
        
       
      );

    /*var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return SessionList(
      allSessions: cloudSessions,
    );*/
  }

  Widget buildlist(var newsList,context){
    return ListView.builder(
      shrinkWrap: false,
      itemCount: newsList.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetail(
                    news: newsList[i],
                  ),
                ),
              );
            },
            // dense: true,
            isThreeLine: true,
            trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${newsList[i].news_id}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                     text: "${newsList[i].news_id}\n",
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            
            leading: Hero(
              tag: "${newsList[i].news_id}\n",
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                
                    CachedNetworkImageProvider('https://avatars1.githubusercontent.com/u/12619420?s=400&u=eac38b075e4e4463edfb0f0a8972825cf7803d4c&v=4'),
              ),
            ),
            title: RichText(
              text: TextSpan(
                 text: "${newsList[i].news_id}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                       text: "${newsList[i].news_id}\n",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 14,
                            color: Tools.multiColors[Random().nextInt(4)],
                          ),
                      children: []),
                ],
              ),
            ),
            subtitle: Text(
              "${newsList[i].news_id}\n",
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 10.0,
                  ),
            ),
          ),
        );
      },
    );

  }
}
class RefreshBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
        "https://images.unsplash.com/photo-1541701494587-cb58502866ab?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0c21b1ac3066ae4d354a3b2e0064c8be&auto=format&fit=crop&w=500&q=60",
        fit: BoxFit.cover,
      )),
    );
  }
}

