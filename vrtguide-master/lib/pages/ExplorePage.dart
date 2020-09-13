import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

import 'package:vrtguide/helpers/ApiConnect.dart';
import 'package:vrtguide/pages/LandmarkPage.dart';

class ExplorePage extends StatefulWidget {
  createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage> {
  CameraController controller;
  List<CameraDescription> cameras;
  String imagePath;
  bool clicking = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    availableCameras().then((val) {
      cameras = val;
      print(cameras);
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Positioned(
              left: (MediaQuery.of(context).size.width / 2.0) - 40.0,
              bottom: 20.0,
              child: clicking == false
                  ? IconButton(
                      onPressed: () {
                        getImage();
                      },
                      iconSize: 80.0,
                      icon: Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 10.0,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void getImage() async {
    try {
      setState(() {
        clicking = true;
      });
      String filePath = await takePicture();
      if (mounted) imagePath = filePath;
      File image = File(imagePath);
      List<int> imageAsBytes = await image.readAsBytes();
      String imageBase64 = base64Encode(imageAsBytes);
      Map data = await ApiConnect.predict(imageBase64);
      if (data.containsKey("success") && data["success"]) {
        Map landmarkInfo = await ApiConnect.getLandmarkInfoById(
            int.parse(data["data"].toString()));
        if (landmarkInfo.containsKey("success") && landmarkInfo["success"]) {
          print(landmarkInfo["data"]["landmark_info"]);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  LandmarkPage(landmarkInfo["data"]["landmark_info"])));
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Landmark Undetected."),
            duration: Duration(seconds: 2),
          ));
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Landmark Undetected."),
          duration: Duration(seconds: 2),
        ));
      }
      setState(() {
        clicking = false;
      });
    } catch (e) {
      setState(() {
        clicking = false;
      });
      print(e);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Landmark Undetected."),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<String> takePicture() async {
    try {
      if (controller == null || !controller.value.isInitialized) return null;
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/flutter_test';
      await Directory(dirPath).create(recursive: true);
      final String filePath =
          '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
      if (controller.value.isTakingPicture) return null;
      await controller.takePicture(filePath);
      return filePath;
    } catch (e) {
      print(e);
      return null;
    }
  }
  /*
  void getImage(bool isCamera) async {
    try {
      File imageSelected = await ImagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 5000.0,
        maxWidth: 5000.0,
      );
      if (imageSelected == null) {
        print("Image not selected.");
        setState(() {});
        return;
      }
      List<int> imageAsBytes = await imageSelected.readAsBytes();
      imageBase64 = base64Encode(imageAsBytes);
      print(imageBase64);
      var dio = Dio();
      Response response = await dio.post("http://192.168.43.13:5000/predict",
          data: {"string": imageBase64});
      print(response.toString());
      setState(() {});
    } catch (e) {
      print(e);
      setState(() {});
    }
  }*/
}
