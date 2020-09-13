import 'package:flutter/material.dart';

import 'package:vrtguide/widgets/LandmarkCard.dart';
import 'package:vrtguide/helpers/ApiConnect.dart';

class HistoryItineraryPage extends StatefulWidget {
  final List<String> lids;
  HistoryItineraryPage(this.lids);
  createState() => HistoryItineraryPageState(lids);
}

class HistoryItineraryPageState extends State<HistoryItineraryPage> {
  final List<String> lids;

  HistoryItineraryPageState(this.lids);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.view_list),
        title: Text('Landmarks'),
      ),
      body: FutureBuilder(
        future: ApiConnect.getLandmarks(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          } else {
            Map data = snapshot.data;
            if (data.containsKey("success") && data["success"]) {
              List<Widget> ret = [];
              for (Map ele in data["data"]["landmarks"]) {
                ele["tags"] = data["data"]["tags"][ele["lid"].toString()] ?? [];
                if (lids.contains( ele["lid"].toString() ))
                  ret.add(LandmarkCard(ele));
              }
              return ListView(
                padding: EdgeInsets.all(10.0),
                children: ret,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
