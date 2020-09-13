import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class HotelEatCard extends StatefulWidget {
  final Map data;
  HotelEatCard(this.data);
  createState() => HotelEatCardState(data);
}

class HotelEatCardState extends State<HotelEatCard> {
  final Map data;
  HotelEatCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: GestureDetector(
          onTap: () async {
            String mapUrl =
                'https://www.google.com/maps/search/?api=1&query=${data['lat']},${data['lng']}';
            if (await canLaunch(mapUrl)) {
              await launch(mapUrl);
            }
          },
          child: SizedBox(
            height: 188.0,
            width: 292.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: <Widget>[
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7),
                      BlendMode.darken,
                    ),
                    child: FadeInImage.assetNetwork(
                      image: data['img'],
                      height: 188.0,
                      width: 292.0,
                      fit: BoxFit.cover,
                      placeholder: "lib/assets/landscape_default.png",
                    ),
                  ),
                  Positioned(
                      left: 16.0,
                      bottom: 16.0,
                      child: RichText(
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: data['caption'] + "\n",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: "( Rs."+ data['mincost'].toString() + " per person )",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                  data['isp']
                      ? Positioned(
                          top: 16.0,
                          left: 16.0,
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Color(0xff139113),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              "Promoted",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
