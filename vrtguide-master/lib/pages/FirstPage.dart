import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:vrtguide/pages/HomePage.dart';

class FirstPage extends StatefulWidget {
  createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  int totalCards = 2;
  int currentIndex = 0;
  List<String> titles = [
    "Planning a\ntrip to Goa?",
    "Already\nin Goa?",
  ];
  List<String> bodies = [
    "We've got Explore, Landmark Detection, Blogs and up-to-date information on the hot locations with customer reviews.",
    "We've got Explore, Landmark Detection, Blogs and up-to-date information on the hot locations with customer reviews.",
  ];
  FirstPageState() {
    totalCards = 2;
    currentIndex = 0;
  }
  /*
  List<PageViewModel> pages = [
    PageViewModel(
      title: "Planning a trip to Goa?",
      body:
          "We've got Explore, Landmark Detection, Blogs and up-to-date information on the hot locations with customer reviews.",
      image: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
          child: Image.asset("lib/assets/beach_portrait.jpg"),
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
    ),
    PageViewModel(
      title: "Already in Goa?",
      body:
          "We've got Explore, Landmark Detection, Blogs and up-to-date information on the hot locations with customer reviews.",
      image: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
          child: Image.asset("lib/assets/beach_portrait.jpg"),
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
        bodyTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
    ),
  ];
  Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
  */
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/backgroundFirstPage.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: GestureDetector(
                onHorizontalDragEnd: (val) {
                  setState(() {
                    currentIndex += 1;
                    currentIndex %= totalCards;
                  });
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                      child: Text(
                        titles[currentIndex],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          child: Text(
                            bodies[currentIndex],
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          child: DotsIndicator(
                            dotsCount: totalCards,
                            position: currentIndex.toDouble(),
                            decorator: DotsDecorator(
                              activeColor: Color(0xff767676),
                              color: Color(0xffC4C4C4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: ButtonTheme(
                minWidth: 112.0,
                height: 48.0,
                child: RaisedButton(
                  elevation: 20.0,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    currentIndex == (totalCards - 1) ? "Done" : "Skip",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
