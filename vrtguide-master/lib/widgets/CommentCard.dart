import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  final Map data;
  CommentCard(this.data);
  createState() => CommentCardState(data);
}

class CommentCardState extends State<CommentCard> {
  final Map data;
  CommentCardState(this.data);
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
        child: ListTile(
          isThreeLine: true,
          contentPadding: EdgeInsets.all(10.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.asset(
              data['img'],
              height: 50.0,
              width: 50.0,
            ),
          ),
          title: Text(
            data['name'],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20.0,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20.0,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20.0,
                  ),
                  Icon(
                    Icons.star_half,
                    color: Colors.yellow,
                    size: 20.0,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                    size: 20.0,
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                data['comments'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
