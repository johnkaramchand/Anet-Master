import 'package:anet/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  static const String routeName = "/news_details";
  final News news;

  NewsDetail({Key key, @required this.news}) : super(key: key);
/*
  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.twitter,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].twitterUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].githubUrl);
              },
            ),
          ],
        ),
      );
*/
  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*  Center(
                  child: CachedNetworkImage(
                // imageUrl: "${news.n_image}",
                imageUrl:
                    "https://img.etimg.com/thumb/msid-68333505,width-643,imgsize-204154,resizemode-4/googlechrome.jpg",
              )), */

              SizedBox(
                height: 20,
              ),
              Text(
                "${news.n_title}",
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                //  "${news.n_id}",
                "${news.n_author}\n${news.n_datetime}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14,
                      color: Colors.green,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  news.n_desc.toString(),
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              news.n_link.toString().length > 5
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          print("clicked");
                          _register(news.n_link);
                        },
                        shape: StadiumBorder(),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "open",
                                style: TextStyle(
                                    //color: Colors.black,
                                    //  fontFamily: 'Raleway',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.open_in_browser)
                            ]),
                        color: Colors.green,
                      ),
                    )
                  : SizedBox(),
              // socialActions(context),
            ],
          ),
        ),
      ),
      title: news.n_author.toString(),
    );
  }

  _register(String url) async {
    print("URL :  $url");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
