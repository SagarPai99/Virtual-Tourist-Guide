import 'package:flutter/material.dart';

class RatingCard {
  static List<Widget> getRatingIconList(double rating) {
    List<Widget> ret = [
      Icon(
        Icons.star_border,
        color: Colors.yellow,
      ),
      Icon(
        Icons.star_border,
        color: Colors.yellow,
      ),
      Icon(
        Icons.star_border,
        color: Colors.yellow,
      ),
      Icon(
        Icons.star_border,
        color: Colors.yellow,
      ),
      Icon(
        Icons.star_border,
        color: Colors.yellow,
      ),
    ];
    int totals = rating.floor();
    for( int i = 0 ; i < totals ; i++ ){
      ret[i] = Icon(
        Icons.star,
        color: Colors.yellow,
      );
    }
    if( rating.floorToDouble().compareTo( rating ) != 0 ){
      ret[totals] = Icon(
        Icons.star_half,
        color: Colors.yellow,
      );
    }
    return ret;
  }
}
