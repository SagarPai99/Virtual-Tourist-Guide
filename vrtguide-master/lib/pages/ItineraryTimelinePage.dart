import 'package:flutter/material.dart';

import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:vrtguide/pages/LandmarkPage.dart';

import 'package:vrtguide/widgets/ItineraryCard.dart';

class ItineraryTimelinePage extends StatefulWidget {
  final Map data;
  ItineraryTimelinePage(this.data);
  createState() => ItineraryTimelinePageState(data);
}

class ItineraryTimelinePageState extends State<ItineraryTimelinePage> {
  final Map data;
  ItineraryTimelinePageState(this.data);
  @override
  Widget build(BuildContext context) {
    List<TimelineModel> ret = [];
    int i = 0;
    for (var ele in data.keys) {
      i++;
      ret.add(TimelineModel(
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LandmarkPage(data[ele])));
          },
          child: ItineraryCard({
            "img": data[ele]["portraitTitlePhotoUrl"],
            "caption": data[ele]["name"],
          }),
        ),
        position:
            i % 2 == 1 ? TimelineItemPosition.left : TimelineItemPosition.right,
        icon: Icon(
          Icons.timer,
          size: 20.0,
        ),
        iconBackground: Colors.white,
      ));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.today),
        title: Text("Itinerary Timeline"),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(40.0),
        child: Timeline(
          position: TimelinePosition.Center,
          lineWidth: 5.0,
          lineColor: Colors.white38,
          children: ret,
        ),
      ),
    );
  }
}
