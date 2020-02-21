import 'dart:math';
import 'package:flutter/material.dart';
import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectsPageScreen extends StatelessWidget {
  static const String routeName = "/projects";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DevScaffold(
      title: "projects",
      body: ProjectScreen(
        homeBloc: _homeBloc,
      ),
    );
  }
}

class ProjectScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  ProjectScreen({Key key, this.homeBloc}) : super(key: key);
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (
          BuildContext context,
          HomeState currentState,
        ) {
          if (currentState is UnHomeState) {
            return Center(
              child: SpinKitChasingDots(
                color: Tools.multiColors[Random().nextInt(3)],
              ),
            );
          }
          if (currentState is ErrorHomeState) {
            return Container(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    currentState.errorMessage ?? 'Error',
                    textAlign: TextAlign.center,
                  ),
                ));
          }

          var state = homeBloc.currentState as InHomeState;
          var news = state.newsData.news;
          var newsList = news.where((s) => s.n_id != 0).toList();

          return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              // header: defaultHeader,
              onRefresh: () async {
                print("Pulled down");
                homeBloc.dispatch(LoadHomeEvent());

                /*  var events = state.eventsData.events;
          eventSessions = events.where((s) => s.e_state == false).toList(); */
                _refreshController.refreshCompleted();
              },
              child: Padding(
                padding: EdgeInsets.all(2),
                child: buildlist(newsList, context),
              ) //EventList( allEvents: eventSessions)

              );
        });
  }

  Widget buildlist(var newsList, context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: newsList.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            elevation: 1.0,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: ListTile(
                  onTap: () {
                    print("Clicked");
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetail(
                          news: newsList[i],
                        ),
                      ),
                    ); */
                  },
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://duhx21azq7s2f4tri3boig0k-wpengine.netdna-ssl.com/wp-content/uploads/2018/04/hydroponic-cannabis-seedling.jpg"),
                    /*  child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: //"${newsList[i].n_image}",
                          "https://duhx21azq7s2f4tri3boig0k-wpengine.netdna-ssl.com/wp-content/uploads/2018/04/hydroponic-cannabis-seedling.jpg"), */
                  ),
                  // dense: true,
                  isThreeLine: true,
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.more_horiz),
                      Text(
                        "ongoing",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                  /*  Image.network(
                      "https://img.etimg.com/thumb/msid-68333505,width-643,imgsize-204154,resizemode-4/googlechrome.jpg"),
                ), */
                  /*     trailing:Container(
                  
                  child: CachedNetworkImage(
                    
          imageUrl: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAe1BMVEUAAAD///+ioqLV1dXn5+dubm7x8fH29va6urpYWFj5+fkRERHd3d37+/vJyclxcXE+Pj5PT09hYWEmJia7u7sJCQnNzc1ISEjj4+OZmZkeHh4XFxddXV3CwsKwsLCUlJSBgYGJiYlBQUEwMDA2NjZ6enqnp6cyMjIpKSmBMj0oAAAHsElEQVR4nO2d6XqqQAyGARERxX3fbavt/V/hcakLSWhHTWYoJ++/Pvo08yGzZZKM50PSUbDrzIbeX2M471SDVoL0eNk/a4Oe65a+SC+u/aAwCfquG8hAf5rkKYwbrhvHRGNFKowWrhvGyCLCCisz161iZVaBCluum8ROK6uwfAKvEs8KK65bI0LlpjAqVx+8MIuuCss0it6zuCiMXbdEjPisMCnLRI9ppCeFget2CDI9KqyVYS2aRz85KBy4boUo8UHhX98u/UzP9xLXbRAm8UaumyBMyyvzSHok8HaumyBM2+u4boIwHa+ci+4bM+/vuQ0fo+z6FEVRFEVRFEVRFEVRFEVRLNDoW3WXz7/snlXX4zCqRWEzqNqw1l2PTuYqWxvWTgxuwY1pLH22sw5v1qKxsLFvKn6GkaDZYZC15dflbN3Y+5C9lKl2BE1FUqbumCOBvh++iZgaEKamIpYywPfmjERIx4QyVBMwBAgpu77PPqo2cgx1uQ1BZrRdfsuVHDvir2k1T2HIa4fuDAfEg7i2eZaPIYCzTjuIl6PK04xa8WrTPSxfPnPNTKQVTnNNJ3Ezzf3wMcJWM/cz8fkCz4aWEVcYu1YoPl24Vygd06wKVaEqVIWqUBWqQlWoClWhKvw/FAoL7CMfrXU2sgpbv7dAmvRDUuDOtbwjosn1rsWd2cgJdD7MnEnEMmHGrqVdWEkpHLlWdkVosKm71nVDqEpCAWaKK18SAr9cq7pHJLt39btde6QSCrmOXXho8wtsu9aURSDNfulaU5Z0zi2w4X5TkYU9z77nWhFkya0w91zdFcxxA/mhEe5gDjabF60bss8XHdd6MMwbjNwwGncwz4iFG2jYA2uoMEHHpLw7/SLtnC7wBpoXb7Lw/U9WhTmhkE7hnRCLNx1yx3uaK2wuB6vgSfarwcj8beGNajdSmCy3HL2/vjdTaV1hhXE/M17VfjdoWeGSOQp6PsUV5F0qDCUyPX47Q7CpUKhyX/dnq/YUJmKFiIc/LqWsKYx41xZZfnLS2lI4YXd6ZfhhU2NJYYRDI97H4/ET+ZDDznjcwfuF/NB5OwpTeETSmE6Ow3zU3DxmoLs8TfPhAK02cx21dhTCdKe74a/5yPrm7pdCA3PeCseKQtiat/sPI/MemhlQYDpjno/IhkLks8w+bmOnLXA3w6bn5OnYUAizDjfgc9McYZBp2ISf0++pBYUosAVmKxk6/FAEBFzj0udeFhTChqAOYxiDhua8NfwG+SPKK0QvE3aqvhv9c+QEQi8HfP0tKdzAL+ERwczzjv45coXOqe2iuMIaiofAc7NRFYQ+aj6+zoCa9nkVEh0BB9DhiCKjbRURaoUGYepUgdfXRmSOo+GAcKoaDaYLg8a/Ezt+3noVhEcYvyQ4tdUodok4XsYuEeIl4o0awv2AODbACo0Sr4k3ECskXBq82zZsgMjHlVS4NmnAK2ADRKSupEI8I6Lp+DXwaEAsqyUV4i8xX6X2jgwQg4ikQhz6yV0+Ao1lxEQgqbCLvsNdTgXN5kYKjWYLI4Wom7AnJaChhuiHT874xHyIlytoA8VeHwO9JcRQhhUardrwC+jjmkXbpx7eQ8C1N7H3wx5qvLIj+ESRqwnedaE9JH8hNeh9TrFLFDuoN0b/Gm1cQrxeguOAwEVVaLjGDxHnDJkt/9E4TfQA+BQkovWhDdzHUIcyjMZGvz0uj4Z2WBLHeXAHTwxm8McwXHagcRK/HlvwDZEqNQ3YDjzgwTMG09EADDVE8+EwLVNCEe4v8GvazzbVOMgVTLa4+R/AdE0mtws6C4lHnd0BmPeVzGqIGGfgyyF1XRwM39vgr9xPWw+EuPbvevCESGUGhhOpM8t30F8oh+/i4tEZPbZuDL7/d43aMsCf0Ggh8RRwYUFuYN426+l697gTpbedTrfkhgH2QslyX2BOlE06vgLXM5I3i8I9jJUbvbfAKHumRQa4/BArznoDLmci4fvwoGt4I2uOOLKQvv0WnaBJl4OGj1S+CC3yOQhkAt5oQIHMHjYS5M8QLLP9ATc0zE7SHFAMj1h6fBvu/kNLheCRiz+UKemN7ETWSs9jd0XM/3B3yH1DODfEwPF06Z73OG+Dj9OasjGCsAHI/mGtzRboXd8Tp+o2RtF7umQYdiWovthVht31gIxit1CMHZJbBySJwmfJD/KUXsmQbO3VIFg6ul37y1I5l8jKRSE0CxsZXw564D07YY3J3v3l4VXB3MRwavcCnTw+qOmLgaWTATSHcTDhHVmjmL3wxcvMq+vWJHpdZzSp7HfSNxA9T+NjXO9Vn6a36L4Vo+cpiqIoiqIoiqIoiqIoiqIoiqIoyn+I+zAAWYae1WA4B8y84p4m89DxHEYbWaHtSSWBFYXAsx20aZuWJ5ASXSgSTzwDxS0935O6o60gDA4KceGwEtFPDgpdR2+KEvhHhYn0DcLuaKQnhXI5Pc455tyckqTFynE75lT35qQwchQIL8wsuiq0k81rnXNw9ncqfxnXbt/lgC7FCson8VLv6FqOoVKuvti/5g/cCk5EZRpRe7fcgfuSGnFZpv7Gfe5ppmhIWpD0jdfoB5l0AVAWJYn/+maqNwB5kfjC+6QVtDuzv+dkHM467aCF0z7/AX0RZakUBYfWAAAAAElFTkSuQmCC",
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
     ),
                ), */

                  /* leading: Hero(
                  tag: "${newsList[i].n_author}\n",
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                        'https://avatars1.githubusercontent.com/u/12619420?s=400&u=eac38b075e4e4463edfb0f0a8972825cf7803d4c&v=4'),
                  ),
                ) ,*/
                  title: Text(
                    //"${newsList[i].n_title}",
                    "Hydroponics",
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: new RichText(
                    text: new TextSpan(
                      text: 'This item costs ]n',
                      style: new TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                          text: 'iu dfvfdn nfnv fgnnvgfub\n',
                          style: new TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        new TextSpan(
                            text: '123123213213',
                            style: new TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            )),
                      ],
                    ),
                  ) /* Text(
                  "ssdoivnfdvfdfdnb",
                  // "\n${newsList[i].n_author}\n${newsList[i].n_datetime.toString()}",
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 12.0,
                        //  /   color: Colors.grey,
                        fontWeight: FontWeight.w800,
                      ),
                  textAlign: TextAlign.start,
                ), */
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
