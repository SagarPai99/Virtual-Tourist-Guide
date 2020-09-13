import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:vrtguide/pages/PostPage.dart';

class BlogCard extends StatefulWidget {
  final Map data;
  BlogCard(this.data);
  createState() => BlogCardState(data);
}

class BlogCardState extends State<BlogCard> {
  final Map data;
  BlogCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      semanticContainer: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(data['img']),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PostPage(data)));
          },
          child: ListTile(
            isThreeLine: true,
            contentPadding: EdgeInsets.all(10.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.asset(
                "lib/assets/wildlife.jpg",
                height: 50.0,
                width: 50.0,
              ),
            ),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.thumb_up,
                      color: Colors.white70,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      data['upvotes'].toString(),
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.thumb_down,
                      color: Colors.white70,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      data['downvotes'].toString(),
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  data['shortDesc'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "- " + data['subtitle'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15.0,
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
