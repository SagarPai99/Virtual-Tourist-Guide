import 'dart:async';
import 'package:flutter/material.dart';

import 'package:vrtguide/widgets/CategoriesCard.dart';
import 'package:vrtguide/widgets/BlogCard.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class BlogPage extends StatefulWidget {
  createState() => BlogPageState();
}

class BlogPageState extends State<BlogPage>
    with AutomaticKeepAliveClientMixin<BlogPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Set<Marker> markers = Set<Marker>();
  int markerStarter = 1;

  bool needsRefresh;
  bool get wantKeepAlive => needsRefresh == null ? true : !needsRefresh;

  BlogPageState() {
    needsRefresh = false;
    _add(15.542721, 73.811576, {"name": "Hotel Dewa, Goa", "rating": "4.5"});
    _add(15.503631, 73.913801, {"name": "Old Goa Residency", "rating": "3.5"});
    _add(
        15.546328, 73.766580, {"name": "Hard rock goa hotel", "rating": "3.5"});
    _add(15.505475, 73.767614,
        {"name": "Marquis Beach Resort", "rating": "5.0"});
  }

  void _add(double lat, double lng, Map data) {
    markerStarter++;
    markers.add(Marker(
      markerId: MarkerId(markerStarter.toString()),
      position: LatLng(
        lat,
        lng,
      ),
      infoWindow: InfoWindow(
          title: data["name"] + " (" + data["rating"] + ")", snippet: '*'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CategoriesCard({
                    "img": "lib/assets/cat_history.jpg",
                    "caption": "History",
                  }),
                  CategoriesCard({
                    "img": "lib/assets/cat_pilgrimage.jpg",
                    "caption": "Pilgrimage",
                  }),
                  CategoriesCard({
                    "img": "lib/assets/cat_beaches.jpg",
                    "caption": "Beaches",
                  }),
                  CategoriesCard({
                    "img": "lib/assets/cat_adventure.jpg",
                    "caption": "Adventure",
                  }),
                  CategoriesCard({
                    "img": "lib/assets/cat_nature.jpg",
                    "caption": "Nature",
                  }),
                  CategoriesCard({
                    "img": "lib/assets/cat_wildlife.jpg",
                    "caption": "Wildlife",
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Promoted',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 400,
                  height: 400,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(15.503631, 73.913801),
                      zoom: 10.5,
                    ),
                    markers: markers,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Blog',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  BlogCard({
                    "img": "lib/assets/blog_images/adventure1.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/beach1.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/beach2.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/beach3.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/beach4.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/beach5.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/beach6.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/diving1.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/diving2.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/forest1.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                  BlogCard({
                    "img": "lib/assets/blog_images/forest2.jpg",
                    "title": "Leaders of Tommorow",
                    "subtitle": "Aakash Pahwa",
                    "shortDesc":
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes": 121,
                    "downvotes": 50,
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _onRefresh() async {
    needsRefresh = true;
    setState(() {});
  }
}
