import 'package:flutter/material.dart';

import 'package:vrtguide/widgets/BlogCommentCard.dart';

class PostPage extends StatefulWidget {
  final Map data;
  PostPage(this.data);
  createState() => PostPageState(data);
}

class PostPageState extends State<PostPage> {
  final Map data;
  PostPageState(this.data);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          FadeInImage.assetNetwork(
            image:
                "https://www.lonelyplanet.in/wp-content/uploads/2018/08/wayanad-header-750x350.jpg",
            placeholder: "lib/assets/landscape_default.png",
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 10.0),
            child: Text(
              data['title'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.thumb_up,
                  size: 25.0,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  data['upvotes'].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.thumb_down,
                  size: 25.0,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  data['downvotes'].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    data['img'],
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  data['subtitle'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: Text(
              data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString() +
                  data['shortDesc'].toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 5.0),
            child: Text(
              "Comments",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  BlogCommentCard({
                    "img" : "lib/assets/wildlife.jpg",
                    "name" : "Aakash Pahwa",
                    "email" : "aakash10399@gmail.com",
                    "comments" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes" : 127,
                    "downvotes" : 91,
                  }),
                  BlogCommentCard({
                    "img" : "lib/assets/wildlife.jpg",
                    "name" : "Aakash Pahwa",
                    "email" : "aakash10399@gmail.com",
                    "comments" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes" : 127,
                    "downvotes" : 91,
                  }),
                  BlogCommentCard({
                    "img" : "lib/assets/wildlife.jpg",
                    "name" : "Aakash Pahwa",
                    "email" : "aakash10399@gmail.com",
                    "comments" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes" : 127,
                    "downvotes" : 91,
                  }),
                  BlogCommentCard({
                    "img" : "lib/assets/wildlife.jpg",
                    "name" : "Aakash Pahwa",
                    "email" : "aakash10399@gmail.com",
                    "comments" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes" : 127,
                    "downvotes" : 91,
                  }),
                  BlogCommentCard({
                    "img" : "lib/assets/wildlife.jpg",
                    "name" : "Aakash Pahwa",
                    "email" : "aakash10399@gmail.com",
                    "comments" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes" : 127,
                    "downvotes" : 91,
                  }),
                  BlogCommentCard({
                    "img" : "lib/assets/wildlife.jpg",
                    "name" : "Aakash Pahwa",
                    "email" : "aakash10399@gmail.com",
                    "comments" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    "upvotes" : 127,
                    "downvotes" : 91,
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
