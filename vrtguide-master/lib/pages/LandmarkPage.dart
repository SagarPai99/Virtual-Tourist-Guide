import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:expandable/expandable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vrtguide/helpers/ApiConnect.dart';
import 'package:vrtguide/widgets/HotelEatCard.dart';

import 'package:vrtguide/widgets/SimilarNearbyCard.dart';
import 'package:vrtguide/widgets/PictureCard.dart';
import 'package:vrtguide/widgets/CommentCard.dart';
import 'package:vrtguide/widgets/RatingCard.dart';
import 'package:vrtguide/widgets/VideoCard.dart';

class LandmarkPage extends StatefulWidget {
  final Map data;
  LandmarkPage(this.data);
  createState() => LandmarkPageState(data);
}

class LandmarkPageState extends State<LandmarkPage> {
  final Map data;
  FlutterTts flutterTts = FlutterTts();
  LandmarkPageState(this.data);

  void playText(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.isLanguageAvailable("en-US");
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          FadeInImage.assetNetwork(
            image: data['landscapeTitlePhotoUrl'],
            placeholder: "lib/assets/landscape_default.png",
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Text(
                  data['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    playText(data['l_desc'].toString());
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton.icon(
                  color: Color(0xff3C3C3C),
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 17.0,
                  ),
                  label: Text(
                    "Call",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: () async {
                    await UrlLauncher.launch('tel:+${data['contact_phone']}');
                  },
                ),
                RaisedButton.icon(
                  color: Color(0xff3C3C3C),
                  icon: Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 17.0,
                  ),
                  label: Text(
                    "Mail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: () async {
                    await UrlLauncher.launch('mailto:${data['contact_email']}');
                  },
                ),
                RaisedButton.icon(
                  color: Color(0xff3C3C3C),
                  icon: Icon(
                    Icons.pin_drop,
                    color: Colors.white,
                    size: 17.0,
                  ),
                  label: Text(
                    "Maps",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: () async {
                    String mapUrl =
                        'https://www.google.com/maps/search/?api=1&query=${data['lat']},${data['lng']}';
                    if (await UrlLauncher.canLaunch(mapUrl)) {
                      await UrlLauncher.launch(mapUrl);
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: RatingCard.getRatingIconList(
                      double.parse(data['rating'].toString())) +
                  <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.white70,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      data['lookups'].toString(),
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.access_alarm,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  data['start_at'],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  " - ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  data['end_at'],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                iconColor: Colors.white,
                iconPlacement: ExpandablePanelIconPlacement.left,
                animationDuration: const Duration(milliseconds: 500),
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              header: Text(""),
              collapsed: Text(
                data['l_desc'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              expanded: Text(
                data['l_desc'],
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              tapHeaderToExpand: true,
              tapBodyToCollapse: true,
              hasIcon: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: Text(
              "Hotels & Places to Eat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      HotelEatCard({
                        "caption" : "Marquis Beach Resort",
                        "lat" : 15.505475,
                        "lng" : 73.767614,
                        "img" : "https://imgmedia.lbb.in/media/2019/06/5d11d544f5d8b832b2a78832_1561449796217.jpg",
                        "isp" : true,
                        "mincost" : 200
                      }),
                      HotelEatCard({
                        "caption" : "Thalassa",
                        "lat" : 15.743392,
                        "lng" : 73.771981,
                        "img" : "https://b.zmtcdn.com/data/pictures/4/130274/bc93533d232bb8d83746d04084a49acb_featured_v2.jpg",
                        "isp" : true,
                        "mincost" : 150
                      }),
                      HotelEatCard({
                        "caption" : "Viva Panjim",
                        "lat" : 15.496841,
                        "lng" : 73.831297,
                        "img" : "https://media-cdn.tripadvisor.com/media/photo-s/02/3a/59/0c/viva-panjim.jpg",
                        "isp" : false,
                        "mincost" : 300
                      }),
                      HotelEatCard({
                        "caption" : "Hard rock cafe",
                        "lat" : 15.546328,
                        "lng" : 73.766580,
                        "img" : "https://pbs.twimg.com/media/DhKZGhDX0AAtjkh.jpg",
                        "isp" : false,
                        "mincost" : 300
                      }),
                      HotelEatCard({
                        "caption" : "Calamari Bathe and Binge",
                        "lat" : 15.506526,
                        "lng" : 73.766742,
                        "img" : "https://content3.jdmagicbox.com/comp/goa/56/0832P832STD35056/catalogue/calamari-bathe-binge-closed-down-candolim-goa-restaurants-28k78j3.jpg",
                        "isp" : false,
                        "mincost" : 200
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: Text(
              "Videos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: ApiConnect.youtubeApiFetch(
                    this.data['name'].toString().trim() + " Guide"),
                builder: (context, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else {
                    Map data = snapshot.data;
                    if (data.containsKey("success") && data["success"]) {
                      List<Widget> ret = [Container()];
                      for (Map ele in data["data"]) {
                        //ret.add(PictureCard(ele));
                        ret.add(VideoCard({
                          "img": ele['thumbnail'],
                          "caption": ele["title"],
                          "url": ele["url"]
                        }));
                      }
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: ret,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: Text(
              "Pictures",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: ApiConnect.getLandmarkPictures(
                    int.parse(data["lid"].toString())),
                builder: (context, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else {
                    Map data = snapshot.data;
                    if (data.containsKey("success") && data["success"]) {
                      List<Widget> ret = [Container()];
                      for (Map ele in data["data"]) {
                        ret.add(PictureCard(ele));
                      }
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: ret,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: Text(
              "Similar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: ApiConnect.getSimilarLandmarks(
                    int.parse(data["lid"].toString())),
                builder: (context, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else {
                    Map data = snapshot.data;
                    if (data.containsKey("success") && data["success"]) {
                      List<Widget> ret = [];
                      for (Map ele in data["data"]) {
                        ele["landmark_data"]["tags"] = ele["all_tags"];
                        ret.add(SimilarNearbyCard(ele["landmark_data"]));
                      }
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: ret,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: Text(
              "Nearby",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: ApiConnect.getNearbyLandmarks(
                    int.parse(data["lid"].toString())),
                builder: (context, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else {
                    Map data = snapshot.data;
                    if (data.containsKey("success") && data["success"]) {
                      List<Widget> ret = [Container()];
                      for (Map ele in data["data"]) {
                        ret.add(SimilarNearbyCard(ele));
                      }
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: ret,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: Text(
              "Reviews",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  CommentCard({
                    "img": "lib/assets/wildlife.jpg",
                    "name": "Aakash Pahwa",
                    "email": "aakash10399@gmail.com",
                    "comments":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  }),
                  CommentCard({
                    "img": "lib/assets/wildlife.jpg",
                    "name": "Aakash Pahwa",
                    "email": "aakash10399@gmail.com",
                    "comments":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  }),
                  CommentCard({
                    "img": "lib/assets/wildlife.jpg",
                    "name": "Aakash Pahwa",
                    "email": "aakash10399@gmail.com",
                    "comments":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  }),
                  CommentCard({
                    "img": "lib/assets/wildlife.jpg",
                    "name": "Aakash Pahwa",
                    "email": "aakash10399@gmail.com",
                    "comments":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  }),
                  CommentCard({
                    "img": "lib/assets/wildlife.jpg",
                    "name": "Aakash Pahwa",
                    "email": "aakash10399@gmail.com",
                    "comments":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
