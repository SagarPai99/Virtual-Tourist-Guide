import 'package:flutter/material.dart';

import 'package:vrtguide/widgets/LandmarkCard.dart';
import 'package:vrtguide/helpers/ApiConnect.dart';

class LandmarkListPage extends StatefulWidget {
  final Map criteria;
  LandmarkListPage(this.criteria);
  createState() => LandmarkListPageState(criteria);
}

class LandmarkListPageState extends State<LandmarkListPage> {
  final Map criteria;

  LandmarkListPageState(this.criteria);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.view_list),
        title: Text('Landmark List'),
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
                if (!criteria.containsKey("tag") ||
                    criteria["tag"] == null ||
                    criteria["tag"] == "all" ||
                    (criteria.containsKey("tag") &&
                        (ele["tags"] as List)
                            .contains(criteria["tag"])))
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
