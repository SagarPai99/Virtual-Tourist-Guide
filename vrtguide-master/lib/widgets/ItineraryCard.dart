import 'package:flutter/material.dart';

class ItineraryCard extends StatefulWidget {
  final Map data;
  ItineraryCard(this.data);
  createState() => ItineraryCardState(data);
}

class ItineraryCardState extends State<ItineraryCard> {
  final Map data;
  ItineraryCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(data['img']),
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.luminosity),
            fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              data['caption'],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
