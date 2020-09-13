import 'package:flutter/material.dart';

import 'package:vrtguide/pages/LandmarkListPage.dart';

class CategoriesCard extends StatefulWidget {
  final Map data;
  CategoriesCard(this.data);
  createState() => CategoriesCardState(data);
}

class CategoriesCardState extends State<CategoriesCard> {
  final Map data;
  CategoriesCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LandmarkListPage(
                    {"tag": data['caption'].toString().toLowerCase()})));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: <Widget>[
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black26,
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    data['img'],
                    height: 188.0,
                    width: 292.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16.0,
                  bottom: 16.0,
                  child: Text(
                    data['caption'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
