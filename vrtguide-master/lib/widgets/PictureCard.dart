import 'package:flutter/material.dart';

class PictureCard extends StatefulWidget {
  final Map data;
  PictureCard(this.data);
  createState() => PictureCardState(data);
}

class PictureCardState extends State<PictureCard> {
  final Map data;
  PictureCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
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
                image: data['photoUrl'],
                height: 200.0,
                width: 200.0,
                placeholder: "lib/assets/landscape_default.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
