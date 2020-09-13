import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatefulWidget {
  final Map data;
  VideoCard(this.data);
  createState() => VideoCardState(data);
}

class VideoCardState extends State<VideoCard> {
  final Map data;
  VideoCardState(this.data);
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
            data['url'] = data['url'].toString().replaceAll(" ", "");
            if (await canLaunch(data['url'])) {
              launch(data['url']);
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
                    child: Text(
                      data['caption'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Positioned(
                    left: 146.0 - 32.0,
                    bottom: 94.0 - 32.0,
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 64.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
