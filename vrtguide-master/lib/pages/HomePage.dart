import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrtguide/helpers/ApiConnect.dart';

import 'package:vrtguide/pages/ExplorePage.dart';
import 'package:vrtguide/pages/HistoryItineraryPage.dart';
import 'package:vrtguide/pages/ItineraryPage.dart';
import 'package:vrtguide/pages/BlogPage.dart';

import 'package:vrtguide/helpers/UserLogin.dart';
import 'package:vrtguide/pages/LandmarkListPage.dart';

class HomePage extends StatefulWidget {
  createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = PageController(initialPage: 1);
  final _userLogin = UserLogin();
  int _currentIndex = 1;
  List<Widget> pages = [
    ExplorePage(),
    BlogPage(),
    ItineraryPage(),
  ];
  List<String> pageTitles = [
    "Explore",
    "Home",
    "Itinerary",
  ];
  List<Icon> leadingIcon = [
    Icon(Icons.camera_alt),
    Icon(Icons.home),
    Icon(Icons.event_note),
  ];

  HomePageState() {
    _currentIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _currentIndex > 0
          ? AppBar(
              backgroundColor: Colors.black,
              title: Row(
                children: <Widget>[
                  leadingIcon[_currentIndex],
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    pageTitles[_currentIndex],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            )
          : null,
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Aakash Pahwa"),
                accountEmail: Text("aakash10399@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("lib/assets/wildlife.jpg"),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: AssetImage("lib/assets/wildlife.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Image.asset(
                  "lib/assets/google-logo.png",
                  height: 30,
                  width: 30,
                ),
                onTap: () {
                  _userLogin.signIn();
                },
              ),
              Divider(
                color: Colors.white,
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  'Features',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ListTile(
                title: Text(
                  'Explore',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                onTap: () {
                  changePage(0);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(
                  'Blogs',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.chrome_reader_mode,
                  color: Colors.white,
                ),
                onTap: () async {
                  changePage(1);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(
                  'Landmarks',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.view_list,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LandmarkListPage({"tag": "all"})));
                },
              ),
              ListTile(
                title: Text(
                  'Itinerary',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.event_note,
                  color: Colors.white,
                ),
                onTap: () {
                  changePage(2);
                  Navigator.of(context).pop();
                },
              ),
              Divider(
                color: Colors.white,
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  'Promoted',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Theme(
                data: ThemeData(
                  accentColor: Colors.white,
                  unselectedWidgetColor: Colors.white,
                ),
                child: ExpansionTile(
                  leading: Icon(
                    Icons.directions_car,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Book a cab",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        "lib/assets/ola.png",
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text(
                        "OLA",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async{
                        String toGo = "https://olawebcdn.com/assets/ola-universal-link.html?";
                        //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        if( await canLaunch(toGo) ){
                          launch(toGo);
                        }
                      },
                    ),
                    ListTile(
                      leading: Image.asset(
                        "lib/assets/uber.png",
                        height: 30.0,
                        width: 30.0,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Uber",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async{
                        String toGo = "https://m.uber.com/";
                        //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        if( await canLaunch(toGo) ){
                          launch(toGo);
                        }
                      }
                    ),
                  ],
                ),
              ),
              Theme(
                data: ThemeData(
                  accentColor: Colors.white,
                  unselectedWidgetColor: Colors.white,
                ),
                child: ExpansionTile(
                  leading: Icon(
                    Icons.hotel,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Book a hotel",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        "lib/assets/oyo.png",
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text(
                        "OYO",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async{
                        String toGo = "https://www.oyorooms.com/";
                        //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        if( await canLaunch(toGo) ){
                          launch(toGo);
                        }
                      }
                    ),
                    ListTile(
                      leading: Image.asset(
                        "lib/assets/trivago.png",
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text(
                        "Trivago",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async{
                        String toGo = "https://www.trivago.in/";
                        //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        if( await canLaunch(toGo) ){
                          launch(toGo);
                        }
                      }
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  'Users',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ListTile(
                title: Text(
                  'History',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                onTap: () async {
                  List<String> lids = await ApiConnect.getHistoryLandmark();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HistoryItineraryPage(lids)));
                },
              ),
              ListTile(
                title: Text(
                  'Current Itinerary',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.note,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Statistics',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.show_chart,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.white,
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  'Bookmarks',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ListTile(
                title: Text(
                  'Landmarks',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.collections_bookmark,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Blogs',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              Divider(
                color: Colors.white,
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  'Social',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    "lib/assets/fb.png",
                    height: 30.0,
                    width: 30.0,
                  ),
                  Image.asset(
                    "lib/assets/tw.png",
                    height: 30.0,
                    width: 30.0,
                  ),
                  Image.asset(
                    "lib/assets/insta.png",
                    height: 30.0,
                    width: 30.0,
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          /*image: DecorationImage(
            image: AssetImage(""),
            fit: BoxFit.cover,
          ),*/
          color: Colors.white,
        ),
        child: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: pages,
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void changePage(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
