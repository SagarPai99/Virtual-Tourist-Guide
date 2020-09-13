import 'package:flutter/material.dart';

import 'package:vrtguide/pages/LandmarkPage.dart';

class SimilarNearbyCard extends StatefulWidget {
  final Map data;
  SimilarNearbyCard(this.data);
  createState() => SimilarNearbyCardState(data);
}

class SimilarNearbyCardState extends State<SimilarNearbyCard> {
  final Map data;
  SimilarNearbyCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LandmarkPage(data)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.white30,
                offset: Offset(1.0, 1.0),
              ),
            ],
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Stack(
            children: <Widget>[
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black26,
                  BlendMode.darken,
                ),
                child: FadeInImage.assetNetwork(
                  image: data["portraitTitlePhotoUrl"],
                  height: 200.0,
                  width: 200.0,
                  placeholder: "lib/assets/landscape_default.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 10.0,
                bottom: 10.0,
                child: Text(
                  data['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
