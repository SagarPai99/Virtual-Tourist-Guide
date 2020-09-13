import 'package:flutter/material.dart';

import 'package:vrtguide/pages/LandmarkPage.dart';
import 'package:vrtguide/widgets/RatingCard.dart';

class LandmarkCard extends StatefulWidget {
  final Map data;
  LandmarkCard(this.data);
  createState() => LandmarkCardState(data);
}

class LandmarkCardState extends State<LandmarkCard> {
  final Map data;
  LandmarkCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff2C2C2C),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LandmarkPage(data)));
          },
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                  child: FadeInImage.assetNetwork(
                    image: data['landscapeTitlePhotoUrl'],
                    placeholder: "lib/assets/landscape_default.png",
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Text(
                    data['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Text(
                    data['s_desc'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Color(0xffEDD943),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        double.parse(data['rating'].toString())
                            .toStringAsFixed(1),
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
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
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.access_alarm,
                        color: Colors.white70,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        data['start_at'],
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        " - ",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        data['end_at'],
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
